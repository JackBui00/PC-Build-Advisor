"""Local Streamlit interface for the PC Build Advisor."""

from __future__ import annotations

from html import escape

import streamlit as st

from backend.prolog_service import PrologConnectionError, PrologService


st.set_page_config(page_title="PC Build Advisor", page_icon="🖥️", layout="wide")

# Keep the UI categories in one place so the sidebar and build map stay in sync.
# Storage is optional in the current Prolog build format; the other parts are required.
CATEGORIES = [
    ("cpu", "Processor (CPU)", True),
    ("motherboard", "Motherboard", True),
    ("memory", "Memory (RAM)", True),
    ("gpu", "Graphics card (GPU)", True),
    ("cooler", "CPU cooler", True),
    ("case", "Case", True),
    ("psu", "Power supply (PSU)", True),
    ("storage", "Storage (optional)", False),
]

# These names connect the checks returned by Prolog to plain-language labels
# and to the component choices that took part in each rule.
CHECK_DETAILS = {
    "cpu_board": ("CPU ↔ motherboard", ["cpu", "motherboard"], "Socket compatibility"),
    "memory_board": ("Memory ↔ motherboard", ["memory", "motherboard"], "Memory generation"),
    "board_case": ("Motherboard ↔ case", ["motherboard", "case"], "Form factor fit"),
    "gpu_case": ("GPU ↔ case", ["gpu", "case"], "Graphics card clearance"),
    "cooler_cpu": ("Cooler ↔ CPU", ["cooler", "cpu"], "Socket support"),
    "cooler_case": ("Cooler ↔ case", ["cooler", "case"], "Cooler clearance"),
    "psu_wattage": ("PSU ↔ system", ["psu", "cpu", "gpu"], "Estimated power"),
    "storage_board": ("Storage ↔ motherboard", ["storage", "motherboard"], "Connection availability"),
}

STATUS_LABELS = {
    "compatible": "Pass",
    "sufficient": "Sufficient",
    "incompatible": "Conflict",
    "insufficient": "Insufficient",
    "unknown": "Unknown",
    "needs_verification": "Needs verification",
    "missing": "Missing selection",
    "invalid": "Invalid selection",
}


@st.cache_resource(show_spinner="Connecting to SWI-Prolog…")
def get_service() -> PrologService:
    """Load the Prolog service once and reuse it across page reruns."""
    # Loading the knowledge base is relatively expensive, so reuse this connection
    # between Streamlit reruns instead of opening it every time a widget changes.
    return PrologService()


def component_options(service: PrologService, category: str) -> list[dict[str, str]]:
    """Return a category's catalog entries in name order for the selector."""
    return sorted(service.list_components(category), key=lambda part: part["name"].casefold())


def result_status(result: dict) -> str:
    """Get the status field, using unknown when a result has no status."""
    return str(result.get("status", "unknown"))


def status_label(result: dict) -> str:
    """Format a Prolog result as a short label for the UI."""
    status = result_status(result)
    label = STATUS_LABELS.get(status, status.replace("_", " ").title())
    if "required_w" in result:
        label += f" · {result['required_w']} W required"
    if "component_id" in result:
        label += f" · {result['component_id']}"
    return label


def render_build_map(selection: dict[str, str | None], labels: dict, result: dict) -> None:
    """Show selected components and the checks that connect them."""
    # Turn the selected parts and Prolog's returned checks into a compact visual
    # summary. The detailed explanation for each result appears below the map.
    checks_by_name = {check["name"]: check["result"] for check in result["checks"]}
    cards = []
    for category, label, _required in CATEGORIES:
        selected = selection.get(category)
        display = escape(labels.get(category, {}).get(selected, "Not selected"))
        cards.append(
            f'<div class="part"><span class="part-type">{escape(label)}</span>'
            f'<strong>{display}</strong></div>'
        )

    links = []
    for check_name, (label, categories, rule) in CHECK_DETAILS.items():
        check = checks_by_name.get(check_name)
        if check is None:
            continue
        status = result_status(check)
        css = "pass" if status in ("compatible", "sufficient") else (
            "fail" if status in ("incompatible", "insufficient", "invalid") else "unknown"
        )
        parts = " + ".join(CATEGORIES[[item[0] for item in CATEGORIES].index(cat)][1] for cat in categories)
        links.append(
            f'<div class="link {css}"><span class="link-title">{escape(label)}</span>'
            f'<span class="link-rule">{escape(rule)} · {escape(parts)}</span>'
            f'<span class="link-result">{escape(status_label(check))}</span></div>'
        )

    html = """
    <style>
      * { box-sizing: border-box; }
      body { margin: 0; font-family: Inter, ui-sans-serif, system-ui, sans-serif; color: #e8edf7; background: transparent; }
      .map { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 10px; }
      .part, .link { border: 1px solid #34415a; border-radius: 10px; background: #151e2d; padding: 12px; min-height: 73px; }
      .part { display: flex; flex-direction: column; gap: 7px; }
      .part-type, .link-rule { color: #a5b3cb; font-size: 12px; }
      .part strong { font-size: 13px; line-height: 1.35; overflow-wrap: anywhere; }
      .link { position: relative; padding-left: 16px; }
      .link:before { content: ''; position: absolute; left: 0; top: 10px; bottom: 10px; width: 3px; border-radius: 4px; background: #718096; }
      .link.pass:before { background: #41c99b; } .link.fail:before { background: #fa6b75; } .link.unknown:before { background: #e8b95c; }
      .link-title, .link-rule, .link-result { display: block; }
      .link-title { font-size: 13px; font-weight: 650; }
      .link-rule { margin-top: 4px; }
      .link-result { margin-top: 7px; font-size: 12px; font-weight: 600; }
      .section { grid-column: 1 / -1; margin: 8px 0 0; color: #d4deef; font-size: 13px; letter-spacing: .04em; text-transform: uppercase; }
      @media (max-width: 750px) { .map { grid-template-columns: repeat(2, minmax(0, 1fr)); } }
    </style>
    <div class="map"><div class="section">Selected components</div>
    """ + "".join(cards) + '<div class="section">Prolog compatibility relationships</div>' + "".join(links) + "</div>"
    st.html(html)


def find_replacements(service: PrologService, selection: dict[str, str | None], result: dict) -> dict[str, list[dict]]:
    """Find catalog alternatives that improve a failed full-build result."""
    # Only search categories involved in a failed or unresolved rule. Every
    # candidate is checked as part of the whole build before it is suggested.
    failed_categories: set[str] = set()
    for check in result["checks"]:
        status = result_status(check["result"])
        if status not in {"incompatible", "insufficient", "unknown", "needs_verification"}:
            continue
        details = CHECK_DETAILS.get(check["name"])
        if details:
            failed_categories.update(details[1])

    suggestions: dict[str, list[dict]] = {}
    for category in failed_categories:
        current = selection.get(category)
        if not current:
            continue
        candidates = [part for part in component_options(service, category) if part["id"] != current]
        # Limit the number checked so replacement search stays responsive in the UI.
        passing = []
        for candidate in candidates[:12]:
            trial = {**selection, category: candidate["id"]}
            trial_result = service.check_build(**trial)
            if trial_result["verdict"] == "compatible":
                passing.append(candidate)
                if len(passing) == 3:
                    break
        if passing:
            suggestions[category] = passing
    return suggestions


st.title("🖥️ PC Build Advisor")
st.caption("Choose parts, then let the Prolog knowledge base check whether they work together.")

# If SWI-Prolog is missing or the knowledge base cannot load, give setup guidance
# instead of leaving the user with a stack trace.
try:
    service = get_service()
    catalog = {category: component_options(service, category) for category, _, _ in CATEGORIES}
except (PrologConnectionError, OSError, RuntimeError) as exc:
    st.error("Could not start the Prolog knowledge base. Install SWI-Prolog and the Python requirements, then restart the app.")
    with st.expander("Connection details"):
        st.code(str(exc))
    st.stop()

with st.sidebar:
    # Component IDs are passed to Prolog, while people see readable product names.
    st.header("Build components")
    st.caption("Required components are marked with *.")
    selected: dict[str, str | None] = {}
    labels = {}
    for category, label, required in CATEGORIES:
        options = catalog[category]
        labels[category] = {part["id"]: part["name"] for part in options}
        chosen = st.selectbox(
            f"{label}{' *' if required else ''}",
            options=[None] + [part["id"] for part in options],
            format_func=lambda part_id, names=labels[category]: "— Select —" if part_id is None else names[part_id],
            key=f"component_{category}",
        )
        selected[category] = chosen
    check_clicked = st.button("Check build", type="primary", use_container_width=True)

if check_clicked:
    try:
        with st.spinner("Checking compatibility rules…"):
            # Clear the previous result first, so a failed query can't leave stale
            # results on screen as if they belonged to the latest selections.
            st.session_state.pop("build_result", None)
            st.session_state.pop("build_selection", None)
            st.session_state.pop("replacement_suggestions", None)
            st.session_state["build_result"] = service.check_build(**selected)
            st.session_state["build_selection"] = selected.copy()
    except (PrologConnectionError, ValueError, RuntimeError) as exc:
        st.error(f"The build could not be checked: {exc}")

result = st.session_state.get("build_result")
selection = st.session_state.get("build_selection")
if result is None:
    # The first visit has no result to show yet; explain what the app can check.
    st.info("Select your components in the sidebar and choose **Check build** to see compatibility results.")
    st.markdown("### What the advisor checks")
    st.markdown("CPU and motherboard sockets · memory type · motherboard and case fit · GPU and cooler clearances · cooler socket support · PSU capacity · storage connection")
    st.caption("Compatibility is decided by explicit Prolog rules. Missing catalog specifications are reported as unresolved.")
    st.stop()

verdict = result["verdict"]
# Keep the verdict prominent, then let users inspect how each individual rule ran.
verdict_config = {
    "compatible": ("Build is compatible", "success"),
    "incompatible": ("Compatibility issues found", "error"),
    "incomplete": ("Build is incomplete", "warning"),
    "needs_verification": ("Some checks need verification", "warning"),
}
title, level = verdict_config.get(verdict, (verdict.replace("_", " ").title(), "info"))
getattr(st, level)(title)

st.subheader("Build map")
render_build_map(selection, labels, result)

st.subheader("Check results")
for check in result["checks"]:
    name = check["name"]
    detail = CHECK_DETAILS.get(name, (name.replace("_", " ").title(), [], "Prolog rule"))
    result_value = check["result"]
    status = result_status(result_value)
    icon = "✅" if status in ("compatible", "sufficient") else "❌" if status in ("incompatible", "insufficient", "invalid") else "⚠️"
    with st.expander(f"{icon} {detail[0]} — {status_label(result_value)}", expanded=status in {"incompatible", "unknown", "needs_verification", "missing"}):
        st.write(f"**Rule:** {detail[2]}")
        if detail[1]:
            related = [f"{category}: {labels.get(category, {}).get(selection.get(category), 'not selected')}" for category in detail[1]]
            st.write("**Parts considered:** " + " · ".join(related))
        if status in {"unknown", "needs_verification"}:
            st.write("The catalog does not contain enough verified specifications to decide this check.")
        elif status == "missing":
            st.write("Select this required component to run the corresponding compatibility checks.")
        elif status == "compatible":
            st.write("The selected parts satisfy the recorded Prolog rule.")
        elif status == "sufficient":
            st.write("The selected power supply meets the estimated system requirement.")
        elif status in {"incompatible", "insufficient"}:
            st.write("The selected parts do not satisfy this Prolog rule. See the rule and selected parts above.")
        st.json(result_value)

if verdict != "compatible" and verdict not in {"incomplete"}:
    # Replacement search is user-triggered because it may check several catalog
    # candidates against the selected build.
    if st.button("Find compatible replacements", key="find_replacements"):
        try:
            with st.spinner("Checking catalog alternatives against the full build…"):
                st.session_state["replacement_suggestions"] = find_replacements(service, selection, result)
        except (PrologConnectionError, ValueError, RuntimeError) as exc:
            st.error(f"Could not check replacements: {exc}")
    suggestions = st.session_state.get("replacement_suggestions")
    if suggestions is not None:
        st.subheader("Replacement options")
        if not suggestions:
            st.info("No fully compatible single-part replacement was found in the current catalog.")
        for category, parts in suggestions.items():
            st.markdown(f"**{category.replace('_', ' ').title()}**")
            for part in parts:
                st.write(f"• {part['name']} — checked against the rest of this build")

with st.expander("How this check ran"):
    st.markdown(
        "1. The UI sends selected component IDs to the Python `PrologService`.\n"
        "2. Python validates IDs and calls `full_build_check` in `knowledge_base.pl`.\n"
        "3. Prolog returns one result per compatibility rule and an overall verdict.\n"
        "4. This page displays those returned results; no language model is involved."
    )
    st.code("Streamlit UI  →  Python PrologService  →  SWI-Prolog rules + catalog", language="text")

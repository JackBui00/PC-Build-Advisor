"""Python interface to the Prolog knowledge base."""

from __future__ import annotations

import re
from pathlib import Path
from typing import Any, TypedDict

from pyswip import Prolog
from pyswip.prolog import PrologError as PySwipError


ComponentId = str
_COMPONENT_ID_PATTERN = re.compile(r"[a-z][a-z0-9_]*\Z")
_COMPONENT_CATEGORIES = {
    "cpu",
    "motherboard",
    "memory",
    "gpu",
    "cooler",
    "case",
    "psu",
    "storage",
}


class Component(TypedDict):
    """A row from the Prolog component catalog."""

    id: str
    category: str
    name: str
    brand: str


class BuildCheck(TypedDict):
    """One result from a build check."""

    name: str
    result: dict[str, Any]


class BuildResult(TypedDict):
    """A build verdict and its checks."""

    verdict: str
    checks: list[BuildCheck]


class PowerEstimate(TypedDict):
    """Estimated draw and required PSU wattage."""

    estimated_draw_w: int
    required_psu_w: int


class PSURecommendation(TypedDict):
    """A PSU that meets the estimate."""

    id: str
    name: str
    required_psu_w: int


class PrologConnectionError(RuntimeError):
    """Raised when PySwip cannot load the knowledge base."""


class PrologService:
    """Python wrapper for queries to the Prolog knowledge base."""

    # Set up the PySwip connection and load the knowledge base.
    def __init__(self, knowledge_base: str | Path | None = None) -> None:
        self.knowledge_base = Path(
            knowledge_base or Path(__file__).with_name("knowledge_base.pl")
        ).resolve()
        if not self.knowledge_base.is_file():
            raise FileNotFoundError(
                f"Prolog knowledge base not found: {self.knowledge_base}"
            )

        self.prolog = Prolog
        try:
            self.prolog.consult(str(self.knowledge_base))
        except (PySwipError, OSError) as exc:
            raise PrologConnectionError(
                f"Could not connect to SWI-Prolog or load the knowledge base: {exc}"
            ) from exc

    # Get every part, or just the ones in a category.
    def list_components(self, category: str | None = None) -> list[Component]:
        if category is not None and category not in _COMPONENT_CATEGORIES:
            raise ValueError(f"Unknown component category: {category}")

        category_term = "Category" if category is None else category
        rows = self._query(f"component(Id, {category_term}, Name, Brand)")
        return [
            {
                "id": str(row["Id"]),
                "category": str(row["Category"] if category is None else category),
                "name": str(row["Name"]),
                "brand": str(row["Brand"]),
            }
            for row in rows
        ]

    # Check the selected parts and return the results.
    def check_build(
        self,
        cpu: ComponentId | None,
        motherboard: ComponentId | None,
        memory: ComponentId | None,
        gpu: ComponentId | None,
        cooler: ComponentId | None,
        case: ComponentId | None,
        psu: ComponentId | None,
        storage: ComponentId | None = None,
    ) -> BuildResult:
        parts = [cpu, motherboard, memory, gpu, cooler, case, psu, storage]
        build = "build(" + ", ".join(
            self._component_atom(part) for part in parts
        ) + ")"
        goal = (
            f"full_build_check({build}, Verdict, Checks), "
            "member(check(Name, Result), Checks), "
            "term_string(Result, ResultText)"
        )
        rows = self._query(goal)
        if not rows:
            raise PrologConnectionError("Prolog returned no build-check results")

        return {
            "verdict": str(rows[0]["Verdict"]),
            "checks": [
                {
                    "name": str(row["Name"]),
                    "result": self._decode_result(row["ResultText"]),
                }
                for row in rows
            ],
        }

    # Get the estimated draw and PSU wattage target.
    def estimate_system_power(self, cpu: ComponentId, gpu: ComponentId) -> PowerEstimate:
        cpu_atom = self._component_atom(cpu)
        gpu_atom = self._component_atom(gpu)
        rows = self._query(
            f"estimated_system_power({cpu_atom}, {gpu_atom}, DrawW, RequiredW)"
        )
        if not rows:
            raise PrologConnectionError("Prolog could not estimate system power")
        return {
            "estimated_draw_w": int(rows[0]["DrawW"]),
            "required_psu_w": int(rows[0]["RequiredW"]),
        }

    # Pick the smallest PSU in the catalog that meets the estimate.
    def lowest_recommended_psu(
        self, cpu: ComponentId, gpu: ComponentId
    ) -> PSURecommendation | None:
        cpu_atom = self._component_atom(cpu)
        gpu_atom = self._component_atom(gpu)
        rows = self._query(
            f"lowest_recommended_psu({cpu_atom}, {gpu_atom}, Psu, RequiredW), "
            "component(Psu, psu, Name, _)"
        )
        if not rows:
            return None
        return {
            "id": str(rows[0]["Psu"]),
            "name": str(rows[0]["Name"]),
            "required_psu_w": int(rows[0]["RequiredW"]),
        }

    # Run a query and return its variable bindings.
    def _query(self, goal: str) -> list[dict[str, Any]]:
        try:
            return list(self.prolog.query(goal, catcherrors=True))
        except PySwipError as exc:
            raise PrologConnectionError(f"Prolog query failed: {exc}") from exc

    # Check an ID before putting it in a Prolog query.
    @staticmethod
    def _component_atom(component_id: ComponentId | None) -> str:
        if component_id is None:
            return "none"
        if not _COMPONENT_ID_PATTERN.fullmatch(component_id):
            raise ValueError(f"Invalid component ID: {component_id!r}")
        return component_id

    # Turn a Prolog result into a Python dictionary.
    @staticmethod
    def _decode_result(term: Any) -> dict[str, Any]:
        if isinstance(term, bytes):
            term = term.decode("utf-8")
        else:
            term = str(term)
        wattage = re.fullmatch(r"(sufficient|insufficient)\((\d+)\)", term)
        if wattage:
            return {
                "status": wattage.group(1),
                "required_w": int(wattage.group(2)),
            }

        invalid = re.fullmatch(r"invalid\(([a-z][a-z0-9_]*)\)", term)
        if invalid:
            return {"status": "invalid", "component_id": invalid.group(1)}

        return {"status": term}

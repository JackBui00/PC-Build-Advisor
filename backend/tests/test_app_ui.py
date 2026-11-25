"""Streamlit UI smoke tests for representative build outcomes."""

import unittest
from pathlib import Path

from streamlit.testing.v1 import AppTest


class BuildAdvisorUITests(unittest.TestCase):
    """Check that users can submit builds and see the returned verdict."""

    def make_app(self):
        """Start the page with enough time for the Prolog knowledge base to load."""
        app_file = Path(__file__).resolve().parents[2] / "app.py"
        return AppTest.from_file(str(app_file), default_timeout=30).run()

    def select_known_build(self, app, memory_id="corsair_vengeance_ddr5_32"):
        """Fill the selectors with a known build, then submit it for checking."""
        parts = {
            "component_cpu": "ryzen_5_7600",
            "component_motherboard": "msi_pro_b650s_wifi",
            "component_memory": memory_id,
            "component_gpu": "msi_rtx_4060_ventus_2x",
            "component_cooler": "thermalright_peerless_assassin_120_se",
            "component_case": "msi_mag_forge_112r",
            "component_psu": "seasonic_focus_gx_550",
            "component_storage": "samsung_990_pro_2tb",
        }
        for key, value in parts.items():
            app.selectbox(key=key).set_value(value)
        app.run()
        app.button[0].click().run()
        return app

    def test_initial_page_renders_build_selectors(self):
        app = self.make_app()

        self.assertEqual(len(app.selectbox), 8)
        self.assertEqual(len(app.exception), 0)
        self.assertTrue(any("Check build" in item.value for item in app.info))

    def test_compatible_build_shows_success_and_rule_results(self):
        app = self.select_known_build(self.make_app())

        self.assertEqual(len(app.exception), 0)
        self.assertTrue(any("Build is compatible" in item.value for item in app.success))
        self.assertGreaterEqual(len(app.expander), 9)

    def test_memory_conflict_shows_incompatible_verdict(self):
        app = self.select_known_build(
            self.make_app(), memory_id="corsair_vengeance_ddr4_32"
        )

        self.assertEqual(len(app.exception), 0)
        self.assertTrue(
            any("Compatibility issues found" in item.value for item in app.error)
        )

    def test_unselected_build_shows_incomplete_verdict(self):
        app = self.make_app()
        app.button[0].click().run()

        self.assertEqual(len(app.exception), 0)
        self.assertTrue(
            any("Build is incomplete" in item.value for item in app.warning)
        )


if __name__ == "__main__":
    unittest.main()

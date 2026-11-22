from pathlib import Path
import sys
import unittest

# Add the project folder so this file also works when run directly.
project_root = Path(__file__).resolve().parents[2]
if str(project_root) not in sys.path:
    sys.path.insert(0, str(project_root))

from backend.prolog_service import PrologService


class PrologServiceTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        # Load the knowledge base once; all tests can share this connection.
        cls.service = PrologService()

    def test_lists_components_by_category(self):
        # A category filter should return only CPUs and include a known model.
        cpus = self.service.list_components("cpu")

        self.assertTrue(cpus)
        self.assertTrue(all(cpu["category"] == "cpu" for cpu in cpus))
        self.assertTrue(any(cpu["id"] == "ryzen_5_7600" for cpu in cpus))

    def test_estimates_system_power(self):
        # Keep the 100 W system allowance and 1.2 headroom calculation in check.
        estimate = self.service.estimate_system_power(
            "ryzen_5_7600", "msi_rtx_4060_ventus_2x"
        )

        self.assertEqual(estimate["estimated_draw_w"], 285)
        self.assertEqual(estimate["required_psu_w"], 342)

    def test_recommends_lowest_sufficient_psu(self):
        # The 550 W unit is the smallest catalog PSU above this build's estimate.
        recommendation = self.service.lowest_recommended_psu(
            "ryzen_5_7600", "msi_rtx_4060_ventus_2x"
        )

        self.assertIsNotNone(recommendation)
        self.assertEqual(recommendation["id"], "seasonic_focus_gx_550")

    def test_accepts_a_compatible_full_build(self):
        # These parts should fit together, including the M.2 drive and cooler.
        result = self.service.check_build(
            cpu="ryzen_5_7600",
            motherboard="msi_pro_b650s_wifi",
            memory="corsair_vengeance_ddr5_32",
            gpu="msi_rtx_4060_ventus_2x",
            cooler="thermalright_peerless_assassin_120_se",
            case="msi_mag_forge_112r",
            psu="seasonic_focus_gx_550",
            storage="samsung_990_pro_2tb",
        )

        self.assertEqual(result["verdict"], "compatible")
        check_statuses = {
            check["name"]: check["result"]["status"] for check in result["checks"]
        }
        self.assertEqual(
            check_statuses,
            {
                "cpu_board": "compatible",
                "memory_board": "compatible",
                "board_case": "compatible",
                "gpu_case": "compatible",
                "cooler_cpu": "compatible",
                "cooler_case": "compatible",
                "psu_wattage": "sufficient",
                "storage_board": "compatible",
            },
        )

    def test_rejects_unknown_categories(self):
        # Catch misspelled categories before sending them to Prolog.
        with self.assertRaises(ValueError):
            self.service.list_components("sound_card")

    def test_rejects_invalid_component_ids(self):
        # Component IDs must not allow arbitrary Prolog query text.
        with self.assertRaises(ValueError):
            self.service._component_atom("cpu);halt")


if __name__ == "__main__":
    unittest.main()

"""Python interface to the Prolog knowledge base."""

from __future__ import annotations

from pathlib import Path
from typing import Any, TypedDict

from pyswip import Prolog


ComponentId = str


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


class PrologService:
    """Python wrapper for queries to the Prolog knowledge base."""

    # Set up the PySwip connection and load the knowledge base.
    def __init__(self, knowledge_base: str | Path | None = None) -> None:
        raise NotImplementedError

    # Get every part, or just the ones in a category.
    def list_components(self, category: str | None = None) -> list[Component]:
        raise NotImplementedError

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
        raise NotImplementedError

    # Get the estimated draw and PSU wattage target.
    def estimate_system_power(self, cpu: ComponentId, gpu: ComponentId) -> PowerEstimate:
        raise NotImplementedError

    # Pick the smallest PSU in the catalog that meets the estimate.
    def lowest_recommended_psu(
        self, cpu: ComponentId, gpu: ComponentId
    ) -> PSURecommendation | None:
        raise NotImplementedError

    # Run a query and return its variable bindings.
    def _query(self, goal: str) -> list[dict[str, Any]]:
        raise NotImplementedError

    # Check an ID before putting it in a Prolog query.
    @staticmethod
    def _component_atom(component_id: ComponentId | None) -> str:
        raise NotImplementedError

    # Turn a Prolog result into a Python dictionary.
    @staticmethod
    def _decode_result(term: Any) -> dict[str, Any]:
        raise NotImplementedError

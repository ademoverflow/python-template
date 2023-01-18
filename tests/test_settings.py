""" Test settings """
from python_template.settings import EXAMPLE_CONSTANT


def test_settings() -> None:
    """Exemple of test"""
    assert isinstance(EXAMPLE_CONSTANT, int)

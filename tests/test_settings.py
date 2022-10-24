from app.settings import EXAMPLE_CONSTANT


def test_settings():
    assert isinstance(EXAMPLE_CONSTANT, int)

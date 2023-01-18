""" Settings module """
import decouple

# Define your python_template settings here (Constants, environment variables, etc.)
EXAMPLE_CONSTANT = decouple.config("EXAMPLE_CONSTANT", default=10, cast=int)


def hello_world(name: str) -> str:
    """Hello World function

    Args:
        name (str): A simple string.

    Returns:
        str: Greeting message
    """

    return f"Hello, {name}"

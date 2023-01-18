""" Main """

from python_template.module_example.example import function_example
from python_template.settings import EXAMPLE_CONSTANT


def main() -> None:
    "Main function to be launched"
    result = function_example(EXAMPLE_CONSTANT, 20)
    print(f"Hello World : {result}.")


if __name__ == "__main__":
    main()

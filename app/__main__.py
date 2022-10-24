from app.module.example import function_example
from app.settings import EXAMPLE_CONSTANT


def main() -> None:
    result = function_example(EXAMPLE_CONSTANT, 20)
    print(f"Hello World: {result}.")


if __name__ == "__main__":
    main()

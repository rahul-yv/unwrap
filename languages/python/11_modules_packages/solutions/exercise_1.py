import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))

from mypackage.helpers import greet


def example_usage():
    return greet("World")


if __name__ == "__main__":
    assert example_usage() == "Hello, World!"
    print("ok")

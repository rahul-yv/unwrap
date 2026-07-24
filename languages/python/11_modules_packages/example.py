from mypackage.helpers import greet


def demo():
    assert greet("Ada") == "Hello, Ada!"

    import sys

    assert "mypackage.helpers" in sys.modules  # cached after first import


if __name__ == "__main__":
    demo()
    print("ok")

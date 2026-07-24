def safe_divide(a, b):
    try:
        return a / b
    except ZeroDivisionError:
        return None


if __name__ == "__main__":
    assert safe_divide(10, 2) == 5.0
    assert safe_divide(10, 0) is None
    print("ok")

def describe(value):
    if value is None:
        return "none"
    if isinstance(value, bool):     # must check before int: bool is an int subtype
        return "bool"
    if isinstance(value, int):
        return "int"
    if isinstance(value, float):
        return "float"
    if isinstance(value, str):
        return "str"
    raise TypeError(f"unsupported type: {type(value)}")


if __name__ == "__main__":
    assert describe(5) == "int"
    assert describe(True) == "bool"
    assert describe(3.14) == "float"
    assert describe("hi") == "str"
    assert describe(None) == "none"
    print("ok")

def demo():
    assert 7 // 2 == 3
    assert 7 % 2 == 1
    assert 2 ** 10 == 1024

    assert (1 < 2 < 3) is True
    assert ((1 < 2) < 3) is True  # True == 1, and 1 < 3

    assert ("" or "fallback") == "fallback"
    assert (0 and "x") == 0

    assert -7 // 2 == -4  # floors toward negative infinity, not toward zero


if __name__ == "__main__":
    demo()
    print("ok")

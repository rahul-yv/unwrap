import math


def demo():
    n = 10
    pi = 3.14159
    name = "Ada"
    ok = True
    nothing = None

    assert isinstance(n, int)
    assert isinstance(pi, float)
    assert isinstance(name, str)
    assert isinstance(ok, bool)
    assert nothing is None

    assert not math.isclose(0.1 + 0.2, 0.3, rel_tol=0, abs_tol=0)  # not bit-exact
    assert math.isclose(0.1 + 0.2, 0.3)  # but close enough for real use

    assert True + True == 2
    assert isinstance(True, int)

    assert 7 / 2 == 3.5
    assert 7 // 2 == 3


if __name__ == "__main__":
    demo()
    print("ok")

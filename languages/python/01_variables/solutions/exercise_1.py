def swap(a, b):
    return b, a


if __name__ == "__main__":
    assert swap(1, 2) == (2, 1)
    assert swap("x", "y") == ("y", "x")
    print("ok")

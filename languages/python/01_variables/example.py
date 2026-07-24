def demo():
    age = 25
    name = "Ada"
    age = age + 1
    assert age == 26
    assert name == "Ada"

    first, second = 1, 2
    assert (first, second) == (1, 2)

    a = b = [1, 2, 3]
    b.append(4)
    assert a is b
    assert a == [1, 2, 3, 4]

    c = a.copy()
    c.append(5)
    assert a != c


if __name__ == "__main__":
    demo()
    print("ok")

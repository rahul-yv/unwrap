def greet(name, greeting="Hello"):
    return f"{greeting}, {name}!"


def total(*args, **kwargs):
    return sum(args) + sum(kwargs.values())


def make_multiplier(n):
    def multiplier(x):
        return x * n

    return multiplier


def buggy_append(item, items=[]):
    items.append(item)
    return items


def fixed_append(item, items=None):
    items = items if items is not None else []
    items.append(item)
    return items


def demo():
    assert greet("Ada") == "Hello, Ada!"
    assert greet("Ada", greeting="Hi") == "Hi, Ada!"

    assert total(1, 2, x=3) == 6

    double = make_multiplier(2)
    assert double(5) == 10

    # mutable default argument pitfall: state leaks across calls
    assert buggy_append(1) == [1]
    assert buggy_append(2) == [1, 2]  # the same list, reused

    assert fixed_append(1) == [1]
    assert fixed_append(2) == [2]  # independent each time

    # closures capture variables by reference, not by value
    late_binding = [lambda: i for i in range(3)]
    assert [f() for f in late_binding] == [2, 2, 2]

    early_binding = [lambda i=i: i for i in range(3)]
    assert [f() for f in early_binding] == [0, 1, 2]


if __name__ == "__main__":
    demo()
    print("ok")

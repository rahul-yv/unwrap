from collections import Counter


def demo():
    nums = [1, 2, 3, 4, 5]
    squares = [n * n for n in nums]
    assert squares == [1, 4, 9, 16, 25]

    evens = {n for n in nums if n % 2 == 0}
    assert evens == {2, 4}

    by_parity = {n: "even" if n % 2 == 0 else "odd" for n in nums}
    assert by_parity[2] == "even"
    assert by_parity[3] == "odd"

    point = (3, 4)
    x, y = point
    assert (x, y) == (3, 4)

    d = {"a": 1, "b": 2}
    assert d.get("c", 0) == 0
    assert d.get("a", 0) == 1

    try:
        d["c"]
        assert False, "expected KeyError"
    except KeyError:
        pass

    words = ["a", "b", "a", "c", "b", "a"]
    assert Counter(words) == Counter({"a": 3, "b": 2, "c": 1})

    deduped_unordered = set(words)
    assert deduped_unordered == {"a", "b", "c"}

    deduped_ordered = list(dict.fromkeys(words))
    assert deduped_ordered == ["a", "b", "c"]


if __name__ == "__main__":
    demo()
    print("ok")

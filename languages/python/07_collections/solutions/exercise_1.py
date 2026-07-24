from collections import Counter


def word_counts(words):
    return dict(Counter(words))


if __name__ == "__main__":
    assert word_counts(["a", "b", "a"]) == {"a": 2, "b": 1}
    assert word_counts([]) == {}
    print("ok")

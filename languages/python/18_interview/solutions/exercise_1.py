from collections import defaultdict


def group_anagrams(words):
    groups = defaultdict(list)
    for word in words:
        key = "".join(sorted(word))
        groups[key].append(word)
    return list(groups.values())


if __name__ == "__main__":
    result = group_anagrams(["eat", "tea", "tan", "ate", "nat", "bat"])
    result_as_sets = {frozenset(group) for group in result}
    expected = {frozenset(["eat", "tea", "ate"]), frozenset(["tan", "nat"]), frozenset(["bat"])}
    assert result_as_sets == expected

    assert group_anagrams([]) == []
    print("ok")

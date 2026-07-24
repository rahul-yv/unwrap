def two_sum(nums, target):
    seen = {}
    for i, n in enumerate(nums):
        complement = target - n
        if complement in seen:
            return [seen[complement], i]
        seen[n] = i
    return None


def is_palindrome(s):
    left, right = 0, len(s) - 1
    while left < right:
        while left < right and not s[left].isalnum():
            left += 1
        while left < right and not s[right].isalnum():
            right -= 1
        if s[left].lower() != s[right].lower():
            return False
        left += 1
        right -= 1
    return True


def merge_intervals(intervals):
    if not intervals:
        return []
    intervals = sorted(intervals, key=lambda pair: pair[0])
    merged = [intervals[0]]
    for start, end in intervals[1:]:
        last_start, last_end = merged[-1]
        if start <= last_end:
            merged[-1] = [last_start, max(last_end, end)]
        else:
            merged.append([start, end])
    return merged


def demo():
    assert two_sum([2, 7, 11, 15], 9) == [0, 1]
    assert two_sum([3, 3], 6) == [0, 1]
    assert two_sum([1, 2], 100) is None

    assert is_palindrome("A man, a plan, a canal: Panama") is True
    assert is_palindrome("race a car") is False
    assert is_palindrome("") is True

    assert merge_intervals([[1, 3], [2, 6], [8, 10], [15, 18]]) == [
        [1, 6],
        [8, 10],
        [15, 18],
    ]
    assert merge_intervals([]) == []
    assert merge_intervals([[1, 4], [4, 5]]) == [[1, 5]]


if __name__ == "__main__":
    demo()
    print("ok")

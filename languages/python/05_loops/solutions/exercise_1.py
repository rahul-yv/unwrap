def first_even(numbers):
    for n in numbers:
        if n % 2 == 0:
            return n
    else:
        return None


if __name__ == "__main__":
    assert first_even([1, 3, 4, 5]) == 4
    assert first_even([1, 3, 5]) is None
    print("ok")

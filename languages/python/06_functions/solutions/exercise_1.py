def make_counter():
    count = 0

    def counter():
        nonlocal count
        count += 1
        return count

    return counter


if __name__ == "__main__":
    counter = make_counter()
    assert counter() == 1
    assert counter() == 2
    assert counter() == 3

    other = make_counter()  # independent state
    assert other() == 1

    print("ok")

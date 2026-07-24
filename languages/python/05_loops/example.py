def demo():
    seen = []
    for i in range(3):
        seen.append(i)
    assert seen == [0, 1, 2]

    n = 0
    while n < 3:
        n += 1
    assert n == 3

    broke = False
    for i in range(5):
        if i == 3:
            broke = True
            break
    else:
        broke = "unreachable"
    assert broke is True

    ran_else = False
    for i in range(3):
        pass
    else:
        ran_else = True
    assert ran_else is True  # no break, so else ran

    items = [1, 2, 3]
    copy_result = []
    for x in items[:]:
        copy_result.append(x)
    assert copy_result == [1, 2, 3]


if __name__ == "__main__":
    demo()
    print("ok")

def clamp(value, low, high):
    return max(low, min(value, high))


if __name__ == "__main__":
    assert clamp(5, 0, 10) == 5
    assert clamp(-5, 0, 10) == 0
    assert clamp(15, 0, 10) == 10
    print("ok")

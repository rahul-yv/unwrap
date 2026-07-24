def grade_if(score):
    if score >= 90:
        return "A"
    elif score >= 80:
        return "B"
    else:
        return "C"


def grade_match(score):
    match score:
        case s if s >= 90:
            return "A"
        case s if s >= 80:
            return "B"
        case _:
            return "C"


def demo():
    assert grade_if(95) == "A"
    assert grade_if(85) == "B"
    assert grade_if(50) == "C"

    assert grade_match(95) == "A"
    assert grade_match(85) == "B"
    assert grade_match(50) == "C"

    score = 85
    label = "pass" if score >= 60 else "fail"
    assert label == "pass"

    match (1, 2):
        case (x, y):
            assert x == 1 and y == 2


if __name__ == "__main__":
    demo()
    print("ok")

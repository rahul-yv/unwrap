def grade(score):
    if score >= 90:
        return "A"
    elif score >= 80:
        return "B"
    elif score >= 70:
        return "C"
    else:
        return "F"


if __name__ == "__main__":
    assert grade(95) == "A"
    assert grade(72) == "C"
    assert grade(40) == "F"
    print("ok")

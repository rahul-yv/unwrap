class InsufficientFundsError(Exception):
    def __init__(self, balance, amount):
        super().__init__(f"cannot withdraw {amount}, balance is {balance}")
        self.balance = balance
        self.amount = amount


def divide(a, b):
    try:
        result = a / b
    except ZeroDivisionError:
        raise ValueError("cannot divide by zero") from None
    else:
        return result
    finally:
        pass


def buggy_finally():
    try:
        return "from try"
    finally:
        return "from finally"  # overrides the try's return — a common bug


def demo():
    assert divide(10, 2) == 5.0

    try:
        divide(10, 0)
        assert False, "expected ValueError"
    except ValueError as e:
        assert str(e) == "cannot divide by zero"
        assert e.__cause__ is None  # `from None` suppressed the original chain

    try:
        raise InsufficientFundsError(balance=10, amount=50)
    except InsufficientFundsError as e:
        assert e.balance == 10
        assert e.amount == 50
        assert "cannot withdraw 50" in str(e)

    assert buggy_finally() == "from finally"


if __name__ == "__main__":
    demo()
    print("ok")

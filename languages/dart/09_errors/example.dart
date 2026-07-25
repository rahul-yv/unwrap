class InvalidAmountException implements Exception {
  final String message;
  InvalidAmountException(this.message);
}

int divide(int a, int b) {
  if (b == 0) {
    throw ArgumentError("division by zero");
  }
  return a ~/ b;
}

void withdraw(double amount) {
  if (amount < 0) {
    throw InvalidAmountException("amount cannot be negative");
  }
}

void main() {
  int result;
  bool finallyRan = false;
  try {
    result = divide(10, 0);
  } on ArgumentError catch (_) {
    result = -1;
  } finally {
    finallyRan = true;
  }
  assert(result == -1);
  assert(finallyRan);

  assert(divide(10, 2) == 5);

  bool caught = false;
  try {
    withdraw(-5);
  } on InvalidAmountException catch (_) {
    caught = true;
  }
  assert(caught);

  print("ok");
}

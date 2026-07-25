import "dart:io";

class TestRunner {
  int run = 0;
  int failed = 0;

  void check(bool condition, String name) {
    run++;
    if (condition) {
      print("PASS: $name");
    } else {
      failed++;
      print("FAIL: $name");
    }
  }

  int summary() {
    print("${run - failed}/$run passed");
    return failed == 0 ? 0 : 1;
  }
}

int add(int a, int b) => a + b;

void main() {
  final t = TestRunner();
  t.check(add(2, 3) == 5, "adds positive numbers");
  t.check(add(-2, -3) == -5, "adds negative numbers");
  final exitCode = t.summary();
  assert(exitCode == 0);
  print("ok");
}

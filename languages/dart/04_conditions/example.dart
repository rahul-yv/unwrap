String describe(Object? value) => switch (value) {
      int i => "an int: $i",
      String s => "a String of length ${s.length}",
      null => "null",
      _ => "something else",
    };

void main() {
  int age = 20;
  String category = age < 13 ? "child" : (age < 20 ? "teen" : "adult");
  assert(category == "adult");

  int x = 5;
  String description = switch (x) {
    < 0 => "negative",
    0 => "zero",
    int n when n.isEven => "positive even",
    _ => "positive odd",
  };
  assert(description == "positive odd");

  assert(describe(42) == "an int: 42");
  assert(describe("hi") == "a String of length 2");
  assert(describe(null) == "null");

  print("ok");
}

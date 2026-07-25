String grade(int score) => switch (score) {
      >= 90 => "A",
      >= 80 => "B",
      >= 70 => "C",
      _ => "F",
    };

void main() {
  assert(grade(95) == "A");
  assert(grade(85) == "B");
  assert(grade(75) == "C");
  assert(grade(50) == "F");
  print("ok");
}

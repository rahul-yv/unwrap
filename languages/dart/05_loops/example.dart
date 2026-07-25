void main() {
  int total = 0;
  for (int i = 0; i < 5; i++) {
    total += i;
  }
  assert(total == 10);

  final items = ["a", "b", "c"];
  final indexed = <String>[];
  for (final (index, value) in items.indexed) {
    indexed.add("$index:$value");
  }
  assert(indexed.join(",") == "0:a,1:b,2:c");

  int count = 0;
  while (count < 3) {
    count++;
  }
  assert(count == 3);

  final doubled = [for (final n in [1, 2, 3]) n * 2];
  assert(doubled.join(",") == "2,4,6");

  int skipped = 0;
  outer:
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (j == 1) continue outer;
      skipped++;
    }
  }
  assert(skipped == 3);

  print("ok");
}

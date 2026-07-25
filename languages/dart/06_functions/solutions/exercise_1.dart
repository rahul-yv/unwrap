int Function() makeCounter() {
  int count = 0;
  return () => ++count;
}

void main() {
  final counter = makeCounter();
  assert(counter() == 1);
  assert(counter() == 2);
  assert(counter() == 3);

  final other = makeCounter();
  assert(other() == 1);

  print("ok");
}

String greet(String name, {String greeting = "Hello"}) => "$greeting, $name!";

int Function(int) makeAdder(int n) {
  return (x) => x + n;
}

int Function() makeCounter() {
  int count = 0;
  return () => ++count;
}

void main() {
  assert(greet("Ada") == "Hello, Ada!");
  assert(greet("Ada", greeting: "Hi") == "Hi, Ada!");

  final addTen = makeAdder(10);
  assert(addTen(5) == 15);

  final counter = makeCounter();
  assert(counter() == 1);
  assert(counter() == 2);

  print("ok");
}

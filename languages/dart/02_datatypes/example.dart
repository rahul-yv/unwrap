void main() {
  int i = 42;
  double d = 3.14;
  String s = "hello";
  bool b = true;
  assert(i == 42 && s == "hello" && b == true);
  assert(d > 3.1 && d < 3.2);

  String? name;
  int length = name?.length ?? 0;
  assert(length == 0);

  int? maybeAge = 25;
  int definiteAge = maybeAge!;
  assert(definiteAge == 25);

  int ratio = 3 ~/ 2;
  double exact = 3 / 2;
  assert(ratio == 1);
  assert(exact == 1.5);

  print("ok");
}

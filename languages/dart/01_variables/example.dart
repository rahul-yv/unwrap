void main() {
  var age = 25;
  String name = "Ada";
  age = age + 1;
  assert(age == 26);
  assert(name == "Ada");

  final maxRetries = 3;
  assert(maxRetries == 3);

  const List<int> point = [3, 4];
  assert(point[0] == 3 && point[1] == 4);

  var mutablePoint = [3, 4];
  var copy = mutablePoint;
  copy[0] = 99;
  assert(mutablePoint[0] == 99);

  print("ok");
}

class Point {
  final int x, y;
  const Point(this.x, this.y);
  Point operator +(Point other) => Point(x + other.x, y + other.y);

  @override
  bool operator ==(Object other) => other is Point && x == other.x && y == other.y;
  @override
  int get hashCode => Object.hash(x, y);
}

void main() {
  int sum = 3 + 4;
  int remainder = 10 % 3;
  assert(sum == 7 && remainder == 1);

  int? x;
  int y = x ?? -1;
  assert(y == -1);
  x ??= 5;
  assert(x == 5);
  x ??= 99;
  assert(x == 5);

  final p = const Point(1, 2) + const Point(3, 4);
  assert(p == const Point(4, 6));

  final buffer = StringBuffer()
    ..write("Hello")
    ..write(", ")
    ..write("world!");
  assert(buffer.toString() == "Hello, world!");

  print("ok");
}

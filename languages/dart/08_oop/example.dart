abstract class Greetable {
  String get name;
  String greet() => "Hello, $name!";
}

class Person extends Greetable {
  @override
  final String name;
  Person(this.name);
}

mixin Loggable {
  String log(String message) => "[$runtimeType] $message";
}

class Service with Loggable {}

sealed class Shape {}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);
}

class Square extends Shape {
  final double side;
  Square(this.side);
}

double area(Shape shape) => switch (shape) {
      Circle(:final radius) => 3.14159 * radius * radius,
      Square(:final side) => side * side,
    };

void main() {
  final ada = Person("Ada");
  assert(ada.greet() == "Hello, Ada!");

  final service = Service();
  assert(service.log("started") == "[Service] started");

  final circleArea = area(Circle(2.0));
  assert(circleArea > 12.5 && circleArea < 12.6);
  assert(area(Square(3.0)) == 9.0);

  print("ok");
}

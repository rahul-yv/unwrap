sealed class Shape {}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);
}

class Rectangle extends Shape {
  final double width, height;
  Rectangle(this.width, this.height);
}

double perimeter(Shape shape) => switch (shape) {
      Circle(:final radius) => 2 * 3.14159 * radius,
      Rectangle(:final width, :final height) => 2 * (width + height),
    };

void main() {
  final circlePerimeter = perimeter(Circle(1.0));
  assert(circlePerimeter > 6.28 && circlePerimeter < 6.29);
  assert(perimeter(Rectangle(2.0, 3.0)) == 10.0);
  print("ok");
}

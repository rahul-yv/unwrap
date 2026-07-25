# Exercises: OOP

1. Define an abstract `class Shape` with pure virtual `double area() const`, then `class Rectangle : public Shape` with `width`/`height` and an `area()` override. Store a `Rectangle` in a `std::unique_ptr<Shape>` and call `area()` through it.
   - `Rectangle(3, 4)` via a `Shape*` → `area()` returns `12`

Check your answer against [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).

#include <cassert>
#include <iostream>
#include <memory>

class Shape {
public:
    virtual ~Shape() = default;
    virtual double area() const = 0;
};

class Rectangle : public Shape {
public:
    Rectangle(double width, double height) : width_(width), height_(height) {}
    double area() const override {
        return width_ * height_;
    }

private:
    double width_;
    double height_;
};

int main() {
    std::unique_ptr<Shape> shape = std::make_unique<Rectangle>(3, 4);
    assert(shape->area() == 12);

    std::cout << "ok\n";
    return 0;
}

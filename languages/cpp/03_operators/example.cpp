#include <cassert>
#include <iostream>

struct Vec2 {
    double x, y;

    Vec2 operator+(const Vec2& other) const {
        return {x + other.x, y + other.y};
    }

    bool operator==(const Vec2& other) const {
        return x == other.x && y == other.y;
    }
};

int main() {
    Vec2 a{1, 2};
    Vec2 b{3, 4};

    Vec2 sum = a + b;
    assert(sum == (Vec2{4, 6}));

    assert(!(a == b));
    assert(a == (Vec2{1, 2}));

    std::cout << "ok\n";
    return 0;
}

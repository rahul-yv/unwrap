#include <cassert>
#include <iostream>
#include <stdexcept>

double safe_divide(double a, double b) {
    if (b == 0) {
        throw std::invalid_argument("division by zero");
    }
    return a / b;
}

int main() {
    assert(safe_divide(10, 2) == 5);

    bool threw = false;
    try {
        safe_divide(10, 0);
    } catch (const std::invalid_argument&) {
        threw = true;
    }
    assert(threw);

    std::cout << "ok\n";
    return 0;
}

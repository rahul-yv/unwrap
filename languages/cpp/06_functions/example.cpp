#include <cassert>
#include <functional>
#include <iostream>
#include <string>

int add(int a, int b) {
    return a + b;
}
double add(double a, double b) {
    return a + b;
}

std::string greet(const std::string& name, const std::string& greeting = "Hello") {
    return greeting + ", " + name + "!";
}

void increment(int& x) {
    x++;
}

template <typename T>
T max_of(T a, T b) {
    return a > b ? a : b;
}

int main() {
    assert(add(2, 3) == 5);         // int overload
    assert(add(2.5, 3.0) == 5.5);   // double overload

    assert(greet("Ada") == "Hello, Ada!");
    assert(greet("Ada", "Hi") == "Hi, Ada!");

    int n = 5;
    increment(n);
    assert(n == 6); // modified through the reference

    assert(max_of(3, 7) == 7);
    assert(max_of(std::string("a"), std::string("b")) == "b");

    // lambda capturing n by value
    auto make_adder = [](int base) {
        return [base](int x) { return x + base; };
    };
    auto add_five = make_adder(5);
    assert(add_five(3) == 8);

    std::cout << "ok\n";
    return 0;
}

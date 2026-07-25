#include <cassert>
#include <iostream>

struct Fraction {
    int num;
    int den;

    bool operator==(const Fraction& other) const {
        return num * other.den == other.num * den;
    }
};

int main() {
    assert((Fraction{1, 2} == Fraction{2, 4}));
    assert(!(Fraction{1, 2} == Fraction{1, 3}));

    std::cout << "ok\n";
    return 0;
}

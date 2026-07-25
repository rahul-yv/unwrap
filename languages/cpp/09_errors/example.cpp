#include <cassert>
#include <iostream>
#include <stdexcept>
#include <string>

class InsufficientFundsError : public std::runtime_error {
public:
    InsufficientFundsError(double balance, double amount)
        : std::runtime_error("insufficient funds"), balance(balance), amount(amount) {}
    double balance;
    double amount;
};

double divide(double a, double b) {
    if (b == 0) {
        throw std::invalid_argument("division by zero");
    }
    return a / b;
}

int main() {
    assert(divide(10, 2) == 5);

    bool caught = false;
    try {
        divide(10, 0);
    } catch (const std::invalid_argument& e) {
        caught = true;
        assert(std::string(e.what()) == "division by zero");
    }
    assert(caught);

    // custom exception carrying data, caught by base reference
    bool caught_custom = false;
    try {
        throw InsufficientFundsError(10, 50);
    } catch (const std::runtime_error& e) {
        caught_custom = true;
        assert(std::string(e.what()) == "insufficient funds");
        // downcast to access the derived data
        const auto* funds = dynamic_cast<const InsufficientFundsError*>(&e);
        assert(funds != nullptr);
        assert(funds->balance == 10 && funds->amount == 50);
    }
    assert(caught_custom);

    std::cout << "ok\n";
    return 0;
}

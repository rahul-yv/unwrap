#include <cassert>
#include <iostream>
#include <optional>

std::optional<int> safe_divide(int a, int b) {
    if (b == 0) {
        return std::nullopt;
    }
    return a / b;
}

int main() {
    assert(safe_divide(10, 2) == 5);
    assert(safe_divide(10, 0) == std::nullopt);
    assert(safe_divide(10, 0).value_or(-1) == -1);

    std::cout << "ok\n";
    return 0;
}

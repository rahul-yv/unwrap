#include <cassert>
#include <iostream>
#include <vector>

int sum_even(const std::vector<int>& numbers) {
    int total = 0;
    for (const auto& n : numbers) {
        if (n % 2 == 0) {
            total += n;
        }
    }
    return total;
}

int main() {
    assert(sum_even({1, 2, 3, 4}) == 6);
    assert(sum_even({1, 3, 5}) == 0);

    std::cout << "ok\n";
    return 0;
}

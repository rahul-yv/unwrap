#include <cassert>
#include <iostream>
#include <vector>

int main() {
    std::vector<int> nums{1, 2, 3};

    int sum = 0;
    for (int x : nums) {
        sum += x;
    }
    assert(sum == 6);

    // reference: modifies elements in place
    for (auto& x : nums) {
        x *= 2;
    }
    assert((nums == std::vector<int>{2, 4, 6}));

    // const reference: read-only, no copy
    int total = 0;
    for (const auto& x : nums) {
        total += x;
    }
    assert(total == 12);

    // classic index loop still available
    std::vector<int> squares;
    for (int i = 0; i < 3; i++) {
        squares.push_back(i * i);
    }
    assert((squares == std::vector<int>{0, 1, 4}));

    std::cout << "ok\n";
    return 0;
}

#include <cassert>
#include <iostream>
#include <utility>

std::pair<int, int> swap_pair(int a, int b) {
    return {b, a};
}

int main() {
    auto result = swap_pair(1, 2);
    assert(result.first == 2 && result.second == 1);

    std::cout << "ok\n";
    return 0;
}

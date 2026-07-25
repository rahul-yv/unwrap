#include <cassert>
#include <iostream>
#include <thread>
#include <vector>

long sum_concurrently(const std::vector<int>& numbers) {
    std::size_t mid = numbers.size() / 2;
    long first_sum = 0;
    long second_sum = 0;

    std::thread t1([&]() {
        for (std::size_t i = 0; i < mid; i++) {
            first_sum += numbers[i];
        }
    });
    std::thread t2([&]() {
        for (std::size_t i = mid; i < numbers.size(); i++) {
            second_sum += numbers[i];
        }
    });

    t1.join();
    t2.join();

    return first_sum + second_sum;
}

int main() {
    assert(sum_concurrently({1, 2, 3, 4}) == 10);
    assert(sum_concurrently({10, 20, 30, 40, 50}) == 150);
    assert(sum_concurrently({}) == 0);

    std::cout << "ok\n";
    return 0;
}

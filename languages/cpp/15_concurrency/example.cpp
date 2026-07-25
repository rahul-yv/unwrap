#include <cassert>
#include <iostream>
#include <mutex>
#include <thread>
#include <vector>

int counter = 0;
std::mutex mtx;

void increment() {
    for (int i = 0; i < 100000; i++) {
        std::lock_guard<std::mutex> lock(mtx);
        counter++;
    }
}

int main() {
    std::vector<std::thread> threads;
    for (int i = 0; i < 4; i++) {
        threads.emplace_back(increment);
    }
    for (auto& t : threads) {
        t.join();
    }
    assert(counter == 400000); // exact: the mutex prevented every lost update

    std::cout << "ok\n";
    return 0;
}

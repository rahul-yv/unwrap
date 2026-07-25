#include <cassert>
#include <functional>
#include <iostream>

std::function<int()> make_counter() {
    int count = 0;
    return [count]() mutable { return ++count; };
}

int main() {
    auto counter = make_counter();
    assert(counter() == 1);
    assert(counter() == 2);
    assert(counter() == 3);

    auto other = make_counter();
    assert(other() == 1); // independent state

    std::cout << "ok\n";
    return 0;
}

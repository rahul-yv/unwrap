#include <cassert>
#include <iostream>
#include <string>
#include <utility>

int main() {
    int age = 25;
    auto name = std::string("Ada");
    age = age + 1;
    assert(age == 26);
    assert(name == "Ada");

    const int max_retries = 3;
    constexpr int buffer_size = 1024;
    assert(max_retries == 3);
    assert(buffer_size == 1024);

    // value semantics: b is an independent copy of a
    std::string a = "hello";
    std::string b = a;
    b += " world";
    assert(a == "hello"); // unchanged
    assert(b == "hello world");

    // brace initialization of a pair
    std::pair<int, int> point{3, 4};
    assert(point.first == 3 && point.second == 4);

    std::cout << "ok\n";
    return 0;
}

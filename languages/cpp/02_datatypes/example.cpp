#include <cassert>
#include <cstdint>
#include <iostream>
#include <optional>
#include <string>

int main() {
    std::string name = "Ada";
    int32_t exact = 10;
    assert(name == "Ada");
    assert(exact == 10);

    std::optional<int> maybe = 42;
    std::optional<int> nothing;

    assert(maybe.has_value());
    assert(maybe.value() == 42);
    assert(*maybe == 42);

    assert(!nothing.has_value());
    assert(nothing.value_or(0) == 0);

    // calling .value() on an empty optional throws
    bool threw = false;
    try {
        nothing.value();
    } catch (const std::bad_optional_access&) {
        threw = true;
    }
    assert(threw);

    // auto copies by default; auto& binds a reference
    std::string original = "hello";
    auto copy = original;
    copy += "!";
    assert(original == "hello");

    auto& ref = original;
    ref += "!";
    assert(original == "hello!");

    std::cout << "ok\n";
    return 0;
}

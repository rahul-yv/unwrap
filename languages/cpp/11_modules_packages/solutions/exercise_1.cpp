#include "../mypackage.hpp"
#include <cassert>
#include <iostream>
#include <string>

std::string example_usage() {
    return mypackage::greet("World");
}

int main() {
    assert(example_usage() == "Hello, World!");

    std::cout << "ok\n";
    return 0;
}

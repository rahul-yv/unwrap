#include "mypackage.hpp"
#include <cassert>
#include <iostream>

int main() {
    assert(mypackage::greet("Ada") == "Hello, Ada!");

    std::cout << "ok\n";
    return 0;
}

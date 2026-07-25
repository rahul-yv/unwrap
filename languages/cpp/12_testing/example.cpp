#include <iostream>
#include <string>

struct TestRunner {
    int run = 0;
    int failed = 0;

    void check(bool condition, const std::string& name) {
        run++;
        if (condition) {
            std::cout << "PASS: " << name << "\n";
        } else {
            failed++;
            std::cout << "FAIL: " << name << "\n";
        }
    }

    int summary() const {
        std::cout << (run - failed) << "/" << run << " passed\n";
        if (failed == 0) {
            std::cout << "ok\n";
        }
        return failed == 0 ? 0 : 1;
    }
};

int add(int a, int b) {
    return a + b;
}

int main() {
    TestRunner t;
    t.check(add(2, 3) == 5, "adds positive numbers");
    t.check(add(-2, -3) == -5, "adds negative numbers");
    t.check(add(0, 0) == 0, "adds zero");
    return t.summary();
}

#include <cassert>
#include <iostream>
#include <string>

std::string grade(int score) {
    if (score >= 90) {
        return "A";
    } else if (score >= 80) {
        return "B";
    } else if (score >= 70) {
        return "C";
    } else {
        return "F";
    }
}

int main() {
    assert(grade(95) == "A");
    assert(grade(72) == "C");
    assert(grade(40) == "F");

    std::cout << "ok\n";
    return 0;
}

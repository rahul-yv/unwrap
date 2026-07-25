#include <cassert>
#include <iostream>
#include <map>
#include <string>

int main() {
    int score = 85;
    std::string grade;
    if (score >= 90) {
        grade = "A";
    } else if (score >= 80) {
        grade = "B";
    } else {
        grade = "C";
    }
    assert(grade == "B");

    std::string label = (score >= 60) ? "pass" : "fail";
    assert(label == "pass");

    // if with an initializer
    std::map<std::string, int> scores{{"Ada", 90}};
    int found = -1;
    if (auto it = scores.find("Ada"); it != scores.end()) {
        found = it->second;
    }
    assert(found == 90);

    // std::string == compares contents
    std::string name = "Ada";
    assert(name == "Ada");
    assert(!(name == "Bob"));

    std::cout << "ok\n";
    return 0;
}

#include <cassert>
#include <cstdio>
#include <fstream>
#include <iostream>
#include <string>

int count_lines(const std::string& path) {
    std::ifstream in(path);
    if (!in) {
        return -1;
    }
    int count = 0;
    std::string line;
    while (std::getline(in, line)) {
        count++;
    }
    return count;
}

int main() {
    std::string path = "/tmp/unwrap-cpp-count.txt";
    {
        std::ofstream out(path);
        out << "a\nb\nc\n";
    }

    assert(count_lines(path) == 3);
    assert(count_lines("/tmp/unwrap-cpp-missing.txt") == -1);

    std::remove(path.c_str());

    std::cout << "ok\n";
    return 0;
}

#include <cassert>
#include <cstdio>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

int main() {
    std::string path = "/tmp/unwrap-cpp-notes.txt";

    {
        std::ofstream out(path);
        assert(out.is_open());
        out << "line one\n"
            << "line two\n";
    } // out's destructor closes the file here

    std::ifstream in(path);
    assert(in.is_open());

    std::vector<std::string> lines;
    std::string line;
    while (std::getline(in, line)) {
        lines.push_back(line);
    }

    assert(lines.size() == 2);
    assert(lines[0] == "line one"); // getline stripped the newline
    assert(lines[1] == "line two");

    // opening a missing file sets a failure state, does not throw
    std::ifstream missing("/tmp/unwrap-cpp-definitely-missing.txt");
    assert(!missing);

    std::remove(path.c_str());

    std::cout << "ok\n";
    return 0;
}

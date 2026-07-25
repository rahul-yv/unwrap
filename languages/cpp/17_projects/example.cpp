#include <algorithm>
#include <cassert>
#include <cctype>
#include <cstdio>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

std::string normalize(const std::string& token) {
    std::string result;
    for (char c : token) {
        if (std::isalpha(static_cast<unsigned char>(c))) {
            result += static_cast<char>(std::tolower(static_cast<unsigned char>(c)));
        }
    }
    return result;
}

std::unordered_map<std::string, int> count_words(const std::string& text) {
    std::unordered_map<std::string, int> counts;
    std::istringstream stream(text);
    std::string token;
    while (stream >> token) {
        std::string word = normalize(token);
        if (!word.empty()) {
            counts[word]++;
        }
    }
    return counts;
}

std::vector<std::pair<std::string, int>> top_words(const std::string& path, int n) {
    std::ifstream in(path);
    std::stringstream buffer;
    buffer << in.rdbuf();

    auto counts = count_words(buffer.str());
    std::vector<std::pair<std::string, int>> entries(counts.begin(), counts.end());
    std::sort(entries.begin(), entries.end(),
              [](const auto& a, const auto& b) { return a.second > b.second; });
    if (static_cast<int>(entries.size()) > n) {
        entries.resize(static_cast<std::size_t>(n));
    }
    return entries;
}

int main() {
    auto counts = count_words("The cat sat. The cat ran!");
    assert(counts["the"] == 2);
    assert(counts["cat"] == 2);
    assert(counts["sat"] == 1);

    std::string path = "/tmp/unwrap-cpp-story.txt";
    {
        std::ofstream out(path);
        out << "dog dog cat bird dog cat";
    }

    auto top = top_words(path, 2);
    assert(top.size() == 2);
    assert(top[0].first == "dog" && top[0].second == 3);
    assert(top[1].first == "cat" && top[1].second == 2);

    std::remove(path.c_str());

    std::cout << "ok\n";
    return 0;
}

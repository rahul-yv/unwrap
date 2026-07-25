#include <cassert>
#include <iostream>
#include <string>
#include <unordered_map>
#include <vector>

std::unordered_map<std::string, int> word_counts(const std::vector<std::string>& words) {
    std::unordered_map<std::string, int> counts;
    for (const auto& word : words) {
        counts[word]++;
    }
    return counts;
}

int main() {
    auto result = word_counts({"a", "b", "a"});
    assert(result["a"] == 2);
    assert(result["b"] == 1);
    assert(result.size() == 2);

    std::cout << "ok\n";
    return 0;
}

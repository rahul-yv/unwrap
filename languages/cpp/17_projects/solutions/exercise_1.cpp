#include <cassert>
#include <iostream>
#include <optional>
#include <string>
#include <unordered_map>
#include <utility>

std::optional<std::pair<std::string, int>> most_frequent(
    const std::unordered_map<std::string, int>& counts) {
    if (counts.empty()) {
        return std::nullopt;
    }
    const std::pair<const std::string, int>* best = nullptr;
    for (const auto& entry : counts) {
        if (best == nullptr || entry.second > best->second) {
            best = &entry;
        }
    }
    return std::make_pair(best->first, best->second);
}

int main() {
    std::unordered_map<std::string, int> counts{{"dog", 3}, {"cat", 2}, {"bird", 1}};
    auto top = most_frequent(counts);
    assert(top.has_value());
    assert(top->first == "dog" && top->second == 3);

    std::unordered_map<std::string, int> empty;
    assert(most_frequent(empty) == std::nullopt);

    std::cout << "ok\n";
    return 0;
}

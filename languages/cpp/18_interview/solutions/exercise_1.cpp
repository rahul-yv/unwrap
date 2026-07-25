#include <algorithm>
#include <cassert>
#include <iostream>
#include <string>
#include <unordered_map>
#include <vector>

std::vector<std::vector<std::string>> group_anagrams(const std::vector<std::string>& words) {
    std::unordered_map<std::string, std::vector<std::string>> groups;
    for (const auto& word : words) {
        std::string key = word;
        std::sort(key.begin(), key.end());
        groups[key].push_back(word);
    }

    std::vector<std::vector<std::string>> result;
    result.reserve(groups.size());
    for (auto& [key, group] : groups) {
        result.push_back(std::move(group));
    }
    return result;
}

int main() {
    auto result = group_anagrams({"eat", "tea", "tan", "ate", "nat", "bat"});
    assert(result.size() == 3);

    std::size_t total = 0;
    for (const auto& group : result) {
        total += group.size();
    }
    assert(total == 6);

    std::cout << "ok\n";
    return 0;
}

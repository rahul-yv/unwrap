#include <algorithm>
#include <cassert>
#include <cctype>
#include <iostream>
#include <optional>
#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

std::optional<std::pair<int, int>> two_sum(const std::vector<int>& nums, int target) {
    std::unordered_map<int, int> seen;
    for (int i = 0; i < static_cast<int>(nums.size()); i++) {
        auto it = seen.find(target - nums[i]);
        if (it != seen.end()) {
            return std::make_pair(it->second, i);
        }
        seen[nums[i]] = i;
    }
    return std::nullopt;
}

bool is_palindrome(const std::string& s) {
    int left = 0, right = static_cast<int>(s.size()) - 1;
    while (left < right) {
        while (left < right && !std::isalnum(static_cast<unsigned char>(s[left]))) {
            left++;
        }
        while (left < right && !std::isalnum(static_cast<unsigned char>(s[right]))) {
            right--;
        }
        if (std::tolower(static_cast<unsigned char>(s[left])) !=
            std::tolower(static_cast<unsigned char>(s[right]))) {
            return false;
        }
        left++;
        right--;
    }
    return true;
}

std::vector<std::vector<int>> merge_intervals(std::vector<std::vector<int>> intervals) {
    if (intervals.empty()) {
        return {};
    }
    std::sort(intervals.begin(), intervals.end(),
              [](const auto& a, const auto& b) { return a[0] < b[0]; });

    std::vector<std::vector<int>> merged{intervals[0]};
    for (std::size_t i = 1; i < intervals.size(); i++) {
        if (intervals[i][0] <= merged.back()[1]) {
            merged.back()[1] = std::max(merged.back()[1], intervals[i][1]);
        } else {
            merged.push_back(intervals[i]);
        }
    }
    return merged;
}

int main() {
    auto ts = two_sum({2, 7, 11, 15}, 9);
    assert(ts.has_value() && ts->first == 0 && ts->second == 1);
    assert(two_sum({1, 2}, 100) == std::nullopt);

    assert(is_palindrome("A man, a plan, a canal: Panama"));
    assert(!is_palindrome("race a car"));

    auto merged = merge_intervals({{1, 3}, {2, 6}, {8, 10}, {15, 18}});
    assert(merged.size() == 3);
    assert(merged[0][0] == 1 && merged[0][1] == 6);

    std::cout << "ok\n";
    return 0;
}

#include <algorithm>
#include <cassert>
#include <iostream>
#include <numeric>
#include <string>
#include <unordered_map>
#include <vector>

int main() {
    std::vector<int> nums{3, 1, 2};
    nums.push_back(4);
    std::sort(nums.begin(), nums.end());
    assert((nums == std::vector<int>{1, 2, 3, 4}));

    int total = std::accumulate(nums.begin(), nums.end(), 0);
    assert(total == 10);

    std::unordered_map<std::string, int> counts;
    counts["a"]++;
    counts["a"]++;
    counts["b"]++;
    assert(counts["a"] == 2);
    assert(counts["b"] == 1);

    // find() checks without inserting
    auto it = counts.find("a");
    assert(it != counts.end() && it->second == 2);
    assert(counts.find("missing") == counts.end());

    // count() to test membership without inserting
    assert(counts.count("a") == 1);
    assert(counts.count("missing") == 0);

    // std::find on a vector
    auto found = std::find(nums.begin(), nums.end(), 3);
    assert(found != nums.end());

    std::cout << "ok\n";
    return 0;
}

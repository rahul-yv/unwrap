func groupAnagrams(_ words: [String]) -> [[String]] {
    var groups: [String: [String]] = [:]
    for word in words {
        let key = String(word.sorted())
        groups[key, default: []].append(word)
    }
    return Array(groups.values)
}

let words = ["eat", "tea", "tan", "ate", "nat", "bat"]
let groups = groupAnagrams(words)

assert(groups.count == 3)
assert(groups.contains { $0.sorted() == ["ate", "eat", "tea"].sorted() })
assert(groups.contains { $0.sorted() == ["nat", "tan"].sorted() })
assert(groups.contains { $0 == ["bat"] })

print("ok")

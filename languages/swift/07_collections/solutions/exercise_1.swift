func wordLengths(_ words: [String]) -> [String: Int] {
    Dictionary(uniqueKeysWithValues: words.map { ($0, $0.count) })
}

let result = wordLengths(["a", "bb", "ccc"])
assert(result == ["a": 1, "bb": 2, "ccc": 3])
print("ok")

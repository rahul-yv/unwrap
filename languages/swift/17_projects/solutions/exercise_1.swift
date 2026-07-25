import Foundation

func countWords(_ text: String) -> [String: Int] {
    var counts: [String: Int] = [:]
    var current = ""

    for c in text.lowercased() {
        if c.isLetter || c == "'" {
            current.append(c)
        } else if !current.isEmpty {
            counts[current, default: 0] += 1
            current = ""
        }
    }
    if !current.isEmpty {
        counts[current, default: 0] += 1
    }

    return counts
}

func topWordsExcluding(path: String, n: Int, stopwords: Set<String>) throws -> [(word: String, count: Int)] {
    let content = try String(contentsOfFile: path, encoding: .utf8)
    let counts = countWords(content)

    return counts
        .filter { !stopwords.contains($0.key) }
        .sorted { $0.value > $1.value }
        .prefix(n)
        .map { (word: $0.key, count: $0.value) }
}

let path = NSTemporaryDirectory() + "unwrap-swift-stopwords-\(ProcessInfo.processInfo.processIdentifier).txt"
try "the dog and the cat and the bird".write(toFile: path, atomically: true, encoding: .utf8)

let stopwords: Set<String> = ["the", "and"]
let top = try topWordsExcluding(path: path, n: 2, stopwords: stopwords)

assert(top.count == 2)
assert(top.allSatisfy { $0.count == 1 })
assert(Set(top.map(\.word)).isSubset(of: ["dog", "cat", "bird"]))

try FileManager.default.removeItem(atPath: path)

print("ok")

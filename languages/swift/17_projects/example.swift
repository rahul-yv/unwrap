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

func topWords(path: String, n: Int) throws -> [(word: String, count: Int)] {
    let content = try String(contentsOfFile: path, encoding: .utf8)
    let counts = countWords(content)

    return counts
        .sorted { $0.value > $1.value }
        .prefix(n)
        .map { (word: $0.key, count: $0.value) }
}

let counts = countWords("The cat sat. The cat ran!")
assert(counts["the"] == 2)
assert(counts["cat"] == 2)

let path = NSTemporaryDirectory() + "unwrap-swift-story-\(ProcessInfo.processInfo.processIdentifier).txt"
try "dog dog cat bird dog cat".write(toFile: path, atomically: true, encoding: .utf8)

let top = try topWords(path: path, n: 2)
assert(top.count == 2)
assert(top[0] == (word: "dog", count: 3))
assert(top[1] == (word: "cat", count: 2))

var threw = false
do {
    _ = try topWords(path: "/tmp/unwrap-swift-missing.txt", n: 2)
} catch {
    threw = true
}
assert(threw)

try FileManager.default.removeItem(atPath: path)

print("ok")

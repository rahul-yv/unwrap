import Foundation

let path = NSTemporaryDirectory() + "unwrap-\(ProcessInfo.processInfo.processIdentifier).txt"

try "line one\nline two\n".write(toFile: path, atomically: true, encoding: .utf8)

let content = try String(contentsOfFile: path, encoding: .utf8)
assert(content == "line one\nline two\n")

let lines = content.split(separator: "\n").map(String.init)
assert(lines == ["line one", "line two"])

let existing = try String(contentsOfFile: path, encoding: .utf8)
try (existing + "line three\n").write(toFile: path, atomically: true, encoding: .utf8)

let updated = try String(contentsOfFile: path, encoding: .utf8)
assert(updated.split(separator: "\n").map(String.init) == ["line one", "line two", "line three"])

try FileManager.default.removeItem(atPath: path)
assert(!FileManager.default.fileExists(atPath: path))

print("ok")

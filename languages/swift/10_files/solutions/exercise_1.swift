import Foundation

func countLines(_ path: String) throws -> Int {
    let content = try String(contentsOfFile: path, encoding: .utf8)
    return content.split(separator: "\n", omittingEmptySubsequences: true).count
}

let path = NSTemporaryDirectory() + "unwrap-\(ProcessInfo.processInfo.processIdentifier)-lines.txt"
try "a\nb\nc\n".write(toFile: path, atomically: true, encoding: .utf8)

let count = try countLines(path)
assert(count == 3)

try FileManager.default.removeItem(atPath: path)
print("ok")

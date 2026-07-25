var total = 0
for i in 0..<5 {
    total += i
}
assert(total == 10)

var descending: [Int] = []
for i in stride(from: 5, through: 1, by: -2) {
    descending.append(i)
}
assert(descending == [5, 3, 1])

let items = ["a", "b", "c"]
var indexed: [String] = []
for (index, value) in items.enumerated() {
    indexed.append("\(index):\(value)")
}
assert(indexed == ["0:a", "1:b", "2:c"])

var count = 0
while count < 3 {
    count += 1
}
assert(count == 3)

var skipped = 0
outer: for _ in 0..<3 {
    for j in 0..<3 {
        if j == 1 { continue outer }
        skipped += 1
    }
}
assert(skipped == 3)

print("ok")

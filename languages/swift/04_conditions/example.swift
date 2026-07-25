func describe(_ value: Any) -> String {
    switch value {
    case let i as Int: return "an Int: \(i)"
    case let s as String: return "a String of length \(s.count)"
    default: return "something else"
    }
}

func firstPositive(_ numbers: [Int]) -> Int {
    guard let found = numbers.first(where: { $0 > 0 }) else {
        return -1
    }
    return found
}

let age = 20
let category = age < 13 ? "child" : (age < 20 ? "teen" : "adult")
assert(category == "adult")

let x = 5
let description: String
switch x {
case ..<0: description = "negative"
case 0: description = "zero"
case let n where n % 2 == 0: description = "positive even"
default: description = "positive odd"
}
assert(description == "positive odd")

assert(describe(42) == "an Int: 42")
assert(describe("hi") == "a String of length 2")

assert(firstPositive([-1, -2, 3, 4]) == 3)
assert(firstPositive([-1, -2]) == -1)

print("ok")

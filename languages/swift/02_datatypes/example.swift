let i: Int = 42
let d: Double = 3.14
let flag: Bool = true
let letter: Character = "A"
let text: String = "hello"
assert(i == 42 && flag && letter == "A" && text == "hello")
assert(d > 3.1 && d < 3.2)

let name: String? = nil
let length = name?.count ?? 0
assert(length == 0)

let present: String? = "hi"
assert((present?.count ?? 0) == 2)

if let unwrapped = present {
    assert(unwrapped == "hi")
} else {
    assertionFailure("should have unwrapped")
}

let big: Int64 = 10_000_000_000
assert(big > Int64(Int32.max))

let ratio = 3 / 2
let exact = 3.0 / 2
assert(ratio == 1)
assert(exact == 1.5)

print("ok")

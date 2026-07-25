let numbers = [1, 2, 3, 4, 5]
var mutable = [1, 2, 3]
mutable.append(4)
assert(mutable == [1, 2, 3, 4])

let doubled = numbers.map { $0 * 2 }
assert(doubled == [2, 4, 6, 8, 10])

let evens = numbers.filter { $0 % 2 == 0 }
assert(evens == [2, 4])

let total = numbers.reduce(0, +)
assert(total == 15)

let ages = ["Ada": 36, "Grace": 85]
assert(ages["Ada"] == 36)
assert(ages["Nobody"] == nil)

let lazyResult = numbers.lazy
    .map { $0 * 2 }
    .filter { $0 > 4 }
    .first
assert(lazyResult == 6)

print("ok")

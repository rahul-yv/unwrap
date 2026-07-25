func makeCounter() -> () -> Int {
    var count = 0
    return {
        count += 1
        return count
    }
}

let counter = makeCounter()
assert(counter() == 1)
assert(counter() == 2)
assert(counter() == 3)

let other = makeCounter()
assert(other() == 1)

print("ok")

func clamp(_ value: Int, min: Int, max: Int) -> Int {
    if (min...max).contains(value) { return value }
    return value < min ? min : max
}

assert(clamp(5, min: 0, max: 10) == 5)
assert(clamp(-5, min: 0, max: 10) == 0)
assert(clamp(15, min: 0, max: 10) == 10)
print("ok")

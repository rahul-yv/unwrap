func safeLength(_ s: String?) -> Int {
    return s?.count ?? 0
}

assert(safeLength(nil) == 0)
assert(safeLength("hello") == 5)
print("ok")

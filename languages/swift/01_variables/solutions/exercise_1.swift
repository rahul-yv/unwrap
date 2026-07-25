func swap(_ a: Int, _ b: Int) -> (Int, Int) {
    return (b, a)
}

let (x, y) = swap(1, 2)
assert(x == 2 && y == 1)
print("ok")

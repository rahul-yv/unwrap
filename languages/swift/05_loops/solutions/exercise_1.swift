func sumEvens(_ n: Int) -> Int {
    var total = 0
    for i in stride(from: 0, through: n, by: 2) {
        total += i
    }
    return total
}

assert(sumEvens(10) == 30)
assert(sumEvens(0) == 0)
print("ok")

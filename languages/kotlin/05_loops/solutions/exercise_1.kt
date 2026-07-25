fun sumEvens(n: Int): Int {
    var total = 0
    for (i in 0..n step 2) {
        total += i
    }
    return total
}

fun main() {
    check(sumEvens(10) == 30)
    check(sumEvens(0) == 0)
    println("ok")
}

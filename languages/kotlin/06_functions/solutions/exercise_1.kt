fun makeCounter(): () -> Int {
    var count = 0
    return {
        count++
        count
    }
}

fun main() {
    val counter = makeCounter()
    check(counter() == 1)
    check(counter() == 2)
    check(counter() == 3)

    val other = makeCounter()
    check(other() == 1)

    println("ok")
}

fun sumConcurrently(numbers: List<Int>): Int {
    val mid = numbers.size / 2
    val left = numbers.subList(0, mid)
    val right = numbers.subList(mid, numbers.size)

    var leftSum = 0
    var rightSum = 0
    val t1 = Thread { leftSum = left.sum() }
    val t2 = Thread { rightSum = right.sum() }
    t1.start(); t2.start()
    t1.join(); t2.join()

    return leftSum + rightSum
}

fun main() {
    check(sumConcurrently(listOf(1, 2, 3, 4, 5, 6)) == 21)
    println("ok")
}

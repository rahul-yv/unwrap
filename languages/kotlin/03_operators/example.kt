data class Point(val x: Int, val y: Int) {
    operator fun plus(other: Point) = Point(x + other.x, y + other.y)
}

fun main() {
    val sum = 3 + 4
    val remainder = 10 % 3
    check(sum == 7 && remainder == 1)

    val inRange = 5 in 1..10
    val notInRange = 15 !in 1..10
    check(inRange && notInRange)

    val a = true
    val b = false
    check((a && b) == false)
    check((a || b) == true)

    val x: Int? = null
    val y = x ?: -1
    check(y == -1)

    val p = Point(1, 2) + Point(3, 4)
    check(p == Point(4, 6))

    println("ok")
}

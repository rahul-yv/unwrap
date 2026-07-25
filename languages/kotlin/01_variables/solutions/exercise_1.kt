fun swap(a: Int, b: Int): Pair<Int, Int> = Pair(b, a)

fun main() {
    val (x, y) = swap(1, 2)
    check(x == 2 && y == 1)
    println("ok")
}

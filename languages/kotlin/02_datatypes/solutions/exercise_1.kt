fun safeLength(s: String?): Int = s?.length ?: 0

fun main() {
    check(safeLength(null) == 0)
    check(safeLength("hello") == 5)
    println("ok")
}

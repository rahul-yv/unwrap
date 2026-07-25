fun safeParseInt(s: String): Result<Int> =
    try {
        Result.success(s.toInt())
    } catch (e: NumberFormatException) {
        Result.failure(e)
    }

fun main() {
    check(safeParseInt("42").getOrNull() == 42)
    check(safeParseInt("not a number").isFailure)
    println("ok")
}

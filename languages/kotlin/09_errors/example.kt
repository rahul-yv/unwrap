fun divide(a: Int, b: Int): Int {
    if (b == 0) throw ArithmeticException("division by zero")
    return a / b
}

fun safeDivide(a: Int, b: Int): Result<Int> =
    if (b == 0) Result.failure(ArithmeticException("division by zero"))
    else Result.success(a / b)

fun main() {
    val result = try {
        divide(10, 0)
    } catch (e: ArithmeticException) {
        -1
    } finally {
        // always runs
    }
    check(result == -1)

    check(divide(10, 2) == 5)

    val outcome = safeDivide(10, 0)
    val message = outcome.fold(
        onSuccess = { value -> "got $value" },
        onFailure = { error -> "failed: ${error.message}" }
    )
    check(message == "failed: division by zero")

    val ok = safeDivide(10, 2)
    check(ok.getOrNull() == 5)

    println("ok")
}

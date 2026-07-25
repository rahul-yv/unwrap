fun describe(value: Any?): String = when (value) {
    is Int -> "an Int: $value"
    is String -> "a String of length ${value.length}"
    null -> "null"
    else -> "something else"
}

fun main() {
    val age = 20
    val category = if (age < 13) "child" else if (age < 20) "teen" else "adult"
    check(category == "adult")

    val x = 5
    val description = when {
        x < 0 -> "negative"
        x == 0 -> "zero"
        x % 2 == 0 -> "positive even"
        else -> "positive odd"
    }
    check(description == "positive odd")

    check(describe(42) == "an Int: 42")
    check(describe("hi") == "a String of length 2")
    check(describe(null) == "null")

    println("ok")
}

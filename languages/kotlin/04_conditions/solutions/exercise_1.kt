fun grade(score: Int): String = when {
    score >= 90 -> "A"
    score >= 80 -> "B"
    score >= 70 -> "C"
    else -> "F"
}

fun main() {
    check(grade(95) == "A")
    check(grade(85) == "B")
    check(grade(75) == "C")
    check(grade(50) == "F")
    println("ok")
}

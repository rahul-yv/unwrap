fun clamp(value: Int, min: Int, max: Int): Int =
    if (value in min..max) value else if (value < min) min else max

fun main() {
    check(clamp(5, 0, 10) == 5)
    check(clamp(-5, 0, 10) == 0)
    check(clamp(15, 0, 10) == 10)
    println("ok")
}

fun main() {
    val i: Int = 42
    val d: Double = 3.14
    val flag: Boolean = true
    val letter: Char = 'A'
    val text: String = "hello"
    check(i == 42 && flag && letter == 'A' && text == "hello")
    check(d > 3.1 && d < 3.2)

    val name: String? = null
    val length = name?.length ?: 0
    check(length == 0)

    val present: String? = "hi"
    check((present?.length ?: 0) == 2)

    val big: Long = 10_000_000_000L
    check(big > Int.MAX_VALUE)

    val ratio = 3 / 2
    val exact = 3.0 / 2
    check(ratio == 1)
    check(exact == 1.5)

    println("ok")
}

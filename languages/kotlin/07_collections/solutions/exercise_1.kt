fun wordLengths(words: List<String>): Map<String, Int> =
    words.associateWith { it.length }

fun main() {
    val result = wordLengths(listOf("a", "bb", "ccc"))
    check(result == mapOf("a" to 1, "bb" to 2, "ccc" to 3))
    println("ok")
}

import java.io.File
import java.io.FileNotFoundException

fun countWords(text: String): Map<String, Int> {
    val counts = mutableMapOf<String, Int>()
    val current = StringBuilder()

    for (c in text.lowercase()) {
        if (c.isLetter() || c == '\'') {
            current.append(c)
        } else if (current.isNotEmpty()) {
            val word = current.toString()
            counts[word] = (counts[word] ?: 0) + 1
            current.clear()
        }
    }
    if (current.isNotEmpty()) {
        val word = current.toString()
        counts[word] = (counts[word] ?: 0) + 1
    }

    return counts
}

fun topWords(path: String, n: Int): List<Pair<String, Int>> {
    val file = File(path)
    if (!file.exists()) throw FileNotFoundException(path)
    val counts = countWords(file.readText())

    return counts.entries
        .sortedByDescending { it.value }
        .take(n)
        .map { it.key to it.value }
}

fun main() {
    val counts = countWords("The cat sat. The cat ran!")
    check(counts["the"] == 2)
    check(counts["cat"] == 2)

    val file = File.createTempFile("unwrap-kotlin-story", ".txt")
    file.writeText("dog dog cat bird dog cat")

    val top = topWords(file.path, 2)
    check(top == listOf("dog" to 3, "cat" to 2))

    var threw = false
    try {
        topWords("/tmp/unwrap-kotlin-missing.txt", 2)
    } catch (e: FileNotFoundException) {
        threw = true
    }
    check(threw)

    file.delete()

    println("ok")
}

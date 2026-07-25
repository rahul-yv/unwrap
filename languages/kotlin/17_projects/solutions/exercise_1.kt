import java.io.File

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

fun topWordsExcluding(path: String, n: Int, stopwords: Set<String>): List<Pair<String, Int>> {
    val counts = countWords(File(path).readText())

    return counts.entries
        .filter { it.key !in stopwords }
        .sortedByDescending { it.value }
        .take(n)
        .map { it.key to it.value }
}

fun main() {
    val file = File.createTempFile("unwrap-kotlin-stopwords", ".txt")
    file.writeText("the dog and the cat and the bird")

    val stopwords = setOf("the", "and")
    val top = topWordsExcluding(file.path, 2, stopwords)

    check(top.size == 2)
    check(top[0] == ("dog" to 1))

    file.delete()

    println("ok")
}

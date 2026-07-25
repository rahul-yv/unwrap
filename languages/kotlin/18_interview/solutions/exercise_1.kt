fun groupAnagrams(words: List<String>): List<List<String>> {
    val groups = mutableMapOf<String, MutableList<String>>()
    for (word in words) {
        val key = word.toCharArray().sorted().joinToString("")
        groups.getOrPut(key) { mutableListOf() }.add(word)
    }
    return groups.values.toList()
}

fun main() {
    val words = listOf("eat", "tea", "tan", "ate", "nat", "bat")
    val groups = groupAnagrams(words)

    check(groups.size == 3)
    check(groups.any { it.sorted() == listOf("ate", "eat", "tea").sorted() })
    check(groups.any { it.sorted() == listOf("nat", "tan").sorted() })
    check(groups.any { it == listOf("bat") })

    println("ok")
}

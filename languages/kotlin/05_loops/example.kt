fun main() {
    var total = 0
    for (i in 0 until 5) {
        total += i
    }
    check(total == 10)

    val descending = mutableListOf<Int>()
    for (i in 5 downTo 1 step 2) {
        descending.add(i)
    }
    check(descending == listOf(5, 3, 1))

    val items = listOf("a", "b", "c")
    val indexed = mutableListOf<String>()
    for ((index, value) in items.withIndex()) {
        indexed.add("$index:$value")
    }
    check(indexed == listOf("0:a", "1:b", "2:c"))

    var count = 0
    while (count < 3) {
        count++
    }
    check(count == 3)

    var skipped = 0
    outer@ for (i in 0 until 3) {
        for (j in 0 until 3) {
            if (j == 1) continue@outer
            skipped++
        }
    }
    check(skipped == 3)

    println("ok")
}

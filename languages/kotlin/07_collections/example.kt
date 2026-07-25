fun main() {
    val numbers = listOf(1, 2, 3, 4, 5)
    val mutable = mutableListOf(1, 2, 3)
    mutable.add(4)
    check(mutable == listOf(1, 2, 3, 4))

    val doubled = numbers.map { it * 2 }
    check(doubled == listOf(2, 4, 6, 8, 10))

    val evens = numbers.filter { it % 2 == 0 }
    check(evens == listOf(2, 4))

    val total = numbers.fold(0) { acc, n -> acc + n }
    check(total == 15)

    val ages = mapOf("Ada" to 36, "Grace" to 85)
    check(ages["Ada"] == 36)
    check(ages["Nobody"] == null)

    val lazyResult = numbers.asSequence()
        .map { it * 2 }
        .filter { it > 4 }
        .first()
    check(lazyResult == 6)

    println("ok")
}

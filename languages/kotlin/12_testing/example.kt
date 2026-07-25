class TestRunner {
    private var run = 0
    private var failed = 0

    fun check(condition: Boolean, name: String) {
        run++
        if (condition) {
            println("PASS: $name")
        } else {
            failed++
            println("FAIL: $name")
        }
    }

    fun summary(): Int {
        println("${run - failed}/$run passed")
        return if (failed == 0) 0 else 1
    }
}

fun add(a: Int, b: Int): Int = a + b

fun main() {
    val t = TestRunner()
    t.check(add(2, 3) == 5, "adds positive numbers")
    t.check(add(-2, -3) == -5, "adds negative numbers")
    val exitCode = t.summary()
    check(exitCode == 0)
    println("ok")
}

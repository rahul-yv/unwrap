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
    t.check(add(0, 0) == 0, "adds zeros")
    t.check(add(-1, 1) == 0, "adds opposite numbers")
    val exitCode = t.summary()
    check(exitCode == 0)
    println("ok")
}

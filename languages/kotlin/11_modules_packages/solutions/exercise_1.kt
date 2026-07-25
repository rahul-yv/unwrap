import mypackage.greet

fun exampleUsage(): String = greet("World")

fun main() {
    check(exampleUsage() == "Hello, World!")
    println("ok")
}

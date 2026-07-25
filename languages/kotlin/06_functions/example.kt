fun greet(name: String, greeting: String = "Hello") = "$greeting, $name!"

fun makeAdder(n: Int): (Int) -> Int = { x -> x + n }

fun String.shout() = this.uppercase() + "!"

fun main() {
    check(greet("Ada") == "Hello, Ada!")
    check(greet("Ada", greeting = "Hi") == "Hi, Ada!")

    val addFive: (Int) -> Int = { x -> x + 5 }
    check(addFive(3) == 8)

    val addTen = makeAdder(10)
    check(addTen(5) == 15)

    check("hello".shout() == "HELLO!")

    println("ok")
}

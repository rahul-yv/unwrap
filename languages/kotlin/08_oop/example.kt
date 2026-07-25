open class Animal(val name: String) {
    open fun sound(): String = "..."
}

class Dog(name: String) : Animal(name) {
    override fun sound(): String = "Woof"
}

data class Point(val x: Int, val y: Int)

sealed interface Shape
data class Circle(val radius: Double) : Shape
data class Square(val side: Double) : Shape

fun area(shape: Shape): Double = when (shape) {
    is Circle -> Math.PI * shape.radius * shape.radius
    is Square -> shape.side * shape.side
}

fun main() {
    val dog = Dog("Rex")
    check(dog.sound() == "Woof")
    check(dog.name == "Rex")

    val p1 = Point(1, 2)
    val p2 = p1.copy(y = 3)
    check(p1 == Point(1, 2))
    check(p2 == Point(1, 3))
    check(p1 != p2)

    val circleArea = area(Circle(2.0))
    check(circleArea > 12.5 && circleArea < 12.6)
    check(area(Square(3.0)) == 9.0)

    println("ok")
}

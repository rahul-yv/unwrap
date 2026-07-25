sealed interface Shape
data class Circle(val radius: Double) : Shape
data class Rectangle(val width: Double, val height: Double) : Shape

fun perimeter(shape: Shape): Double = when (shape) {
    is Circle -> 2 * Math.PI * shape.radius
    is Rectangle -> 2 * (shape.width + shape.height)
}

fun main() {
    val circlePerimeter = perimeter(Circle(1.0))
    check(circlePerimeter > 6.28 && circlePerimeter < 6.29)
    check(perimeter(Rectangle(2.0, 3.0)) == 10.0)
    println("ok")
}

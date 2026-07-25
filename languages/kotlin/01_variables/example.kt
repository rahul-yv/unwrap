fun main() {
    val age = 25
    var name = "Ada"
    name = "Grace"
    check(name == "Grace")

    val maxRetries: Int = 3
    check(maxRetries == 3)

    val point = intArrayOf(3, 4)
    check(point[0] == 3 && point[1] == 4)

    check(age == 25)
    println("ok")
}

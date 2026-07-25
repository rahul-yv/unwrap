import java.io.File

fun countLines(path: String): Int {
    var count = 0
    File(path).forEachLine { count++ }
    return count
}

fun main() {
    val file = File.createTempFile("unwrap", ".txt")
    file.writeText("a\nb\nc\n")

    check(countLines(file.path) == 3)

    file.delete()
    println("ok")
}

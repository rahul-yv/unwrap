import java.io.File

fun main() {
    val file = File.createTempFile("unwrap", ".txt")
    file.writeText("line one\nline two\n")

    val content = file.readText()
    check(content == "line one\nline two\n")

    val lines = file.readLines()
    check(lines == listOf("line one", "line two"))

    file.appendText("line three\n")
    check(file.readLines() == listOf("line one", "line two", "line three"))

    var lineCount = 0
    file.bufferedReader().use { reader ->
        reader.forEachLine { lineCount++ }
    }
    check(lineCount == 3)

    file.delete()
    check(!file.exists())

    println("ok")
}

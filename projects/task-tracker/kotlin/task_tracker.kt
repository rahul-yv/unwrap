import java.io.File

data class Task(val id: Int, val description: String, val done: Boolean)

class TaskNotFoundException(id: Int) : RuntimeException("no task with id $id")

class TaskTracker(private val path: File) {
    private val tasks = mutableListOf<Task>()
    private var nextId = 1

    init {
        if (path.exists()) {
            val pattern = Regex("""\{"id":(\d+),"description":"([^"]*)","done":(true|false)\}""")
            for (match in pattern.findAll(path.readText())) {
                val (id, description, done) = match.destructured
                tasks.add(Task(id.toInt(), description, done.toBoolean()))
            }
            nextId = (tasks.maxOfOrNull { it.id } ?: 0) + 1
        }
    }

    private fun save() {
        val json = tasks.joinToString(",", "[", "]") {
            """{"id":${it.id},"description":"${it.description}","done":${it.done}}"""
        }
        path.writeText(json)
    }

    fun addTask(description: String): Task {
        val task = Task(nextId++, description, false)
        tasks.add(task)
        save()
        return task
    }

    fun listTasks(): List<Task> = tasks.toList()

    private fun findIndex(id: Int): Int =
        tasks.indexOfFirst { it.id == id }.also { if (it < 0) throw TaskNotFoundException(id) }

    fun completeTask(id: Int) {
        val i = findIndex(id)
        tasks[i] = tasks[i].copy(done = true)
        save()
    }

    fun removeTask(id: Int) {
        val i = findIndex(id)
        tasks.removeAt(i)
        save()
    }
}

fun check(condition: Boolean, name: String) {
    if (!condition) throw AssertionError(name)
}

fun main() {
    val path = File(System.getProperty("java.io.tmpdir"), "unwrap-task-tracker-kt-${ProcessHandle.current().pid()}.json")
    val tracker = TaskTracker(path)

    val a = tracker.addTask("write lesson")
    check(a.id == 1 && a.description == "write lesson" && !a.done, "add a")
    val b = tracker.addTask("review PR")
    check(b.id == 2, "add b")

    check(tracker.listTasks().size == 2, "list size 2")

    tracker.completeTask(a.id)
    check(tracker.listTasks()[0].done, "a done")

    val reloaded = TaskTracker(path)
    check(reloaded.listTasks().size == 2, "reloaded size 2")
    check(reloaded.listTasks()[0].done, "reloaded a done")

    reloaded.removeTask(b.id)
    check(reloaded.listTasks().size == 1, "reloaded size 1 after remove")

    var threw = false
    try {
        reloaded.completeTask(999)
    } catch (e: TaskNotFoundException) {
        threw = true
    }
    check(threw, "expected TaskNotFoundException")

    path.delete()
    println("ok")
}

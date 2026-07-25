import java.util.concurrent.atomic.AtomicInteger

fun main() {
    var counter = 0
    val gate = Any()
    val threads = (1..10).map {
        Thread {
            synchronized(gate) { counter++ }
        }
    }
    threads.forEach { it.start() }
    threads.forEach { it.join() }
    check(counter == 10)

    val atomicCounter = AtomicInteger(0)
    val threads2 = (1..10).map {
        Thread { atomicCounter.incrementAndGet() }
    }
    threads2.forEach { it.start() }
    threads2.forEach { it.join() }
    check(atomicCounter.get() == 10)

    println("ok")
}

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.atomic.AtomicInteger;

public class Example {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    public static void main(String[] args) throws Exception {
        boolean[] ran = {false};
        Thread t = new Thread(() -> ran[0] = true);
        t.start();
        t.join();
        check(ran[0], "thread should have run before join() returns");

        try (ExecutorService pool = Executors.newFixedThreadPool(4)) {
            Future<Integer> future = pool.submit(() -> 2 + 2);
            check(future.get() == 4, "future should resolve to the task's result");
        }

        try (ExecutorService virtualPool = Executors.newVirtualThreadPerTaskExecutor()) {
            Future<String> future = virtualPool.submit(() -> Thread.currentThread().isVirtual() ? "virtual" : "platform");
            check(future.get().equals("virtual"), "task should run on a virtual thread");
        }

        // AtomicInteger prevents lost updates from concurrent increments
        AtomicInteger counter = new AtomicInteger(0);
        Thread[] threads = new Thread[10];
        for (int i = 0; i < threads.length; i++) {
            threads[i] = new Thread(() -> {
                for (int j = 0; j < 1000; j++) {
                    counter.incrementAndGet();
                }
            });
            threads[i].start();
        }
        for (Thread thread : threads) {
            thread.join();
        }
        check(counter.get() == 10_000, "AtomicInteger should prevent lost updates");

        // synchronized achieves the same guarantee for arbitrary shared state,
        // not just a single counter value
        Object lock = new Object();
        int[] plainCounter = {0};
        Thread[] syncThreads = new Thread[10];
        for (int i = 0; i < syncThreads.length; i++) {
            syncThreads[i] = new Thread(() -> {
                for (int j = 0; j < 1000; j++) {
                    synchronized (lock) {
                        plainCounter[0]++;
                    }
                }
            });
            syncThreads[i].start();
        }
        for (Thread thread : syncThreads) {
            thread.join();
        }
        check(plainCounter[0] == 10_000, "synchronized should prevent lost updates");

        System.out.println("ok");
    }
}

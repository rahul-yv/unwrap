# Exercises: Functions

1. Write `Supplier<Integer> makeCounter()` returning a `Supplier<Integer>`; each call to `.get()` returns an incrementing count starting at 1. Use a single-element `int[]` to hold the mutable count, since a lambda can't close over a reassigned local.

   ```java
   Supplier<Integer> counter = makeCounter();
   counter.get(); // 1
   counter.get(); // 2
   ```

Check your answer against [`solutions/Exercise1.java`](./solutions/Exercise1.java).

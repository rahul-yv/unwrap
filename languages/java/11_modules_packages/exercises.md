# Exercises: Modules and Packages

1. Using `mypackage/Helpers.java`'s `greet(String name)`, write `exampleUsage()` in `solutions/Exercise1.java` returning `Helpers.greet("World")`.
   - `exampleUsage()` → `"Hello, World!"`

Run it with a two-step command, since `solutions/` is nested one level deeper than `mypackage/`'s sibling:

```sh
javac -d /tmp/unwrap-java-out mypackage/Helpers.java
java -cp /tmp/unwrap-java-out solutions/Exercise1.java
```

Check your answer against [`solutions/Exercise1.java`](./solutions/Exercise1.java).

# Exercises: Modules and Packages

1. Using `mypackage/Helpers.java`'s `greet(String name)`, write `exampleUsage()` in `solutions/Exercise1.java` returning `Helpers.greet("World")`.
   - `exampleUsage()` → `"Hello, World!"`

Compile the package once, then run either file against that classpath:

```sh
javac -d /tmp/unwrap-java-out mypackage/Helpers.java
java -cp /tmp/unwrap-java-out Example.java
java -cp /tmp/unwrap-java-out solutions/Exercise1.java
```

Check your answer against [`solutions/Exercise1.java`](./solutions/Exercise1.java).

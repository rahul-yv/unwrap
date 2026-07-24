# Exercises: Data Types

1. Write `boolean sameContent(String a, String b)` comparing by content using `.equals()`, returning `false` (not throwing) if either is `null`.
   - `sameContent("hi", "hi")` → `true`
   - `sameContent("hi", new String("hi"))` → `true`
   - `sameContent(null, "hi")` → `false`

Check your answer against [`solutions/Exercise1.java`](./solutions/Exercise1.java).

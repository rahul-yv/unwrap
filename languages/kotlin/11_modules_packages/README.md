# Modules and Packages

Every Kotlin file can declare a `package` (matching its directory path, by convention), and `import` brings a declaration from another package into scope. Kotlin has no file-per-class requirement — a file can hold multiple top-level functions, classes, and properties. A **module** is a larger compilation unit (everything compiled together by one `kotlinc`/Gradle invocation) — most everyday code just uses packages, without needing to think about module boundaries explicitly.

## Example

```kotlin
// mypackage/Helpers.kt
package mypackage

fun greet(name: String): String = "Hello, $name!"
```

```kotlin
// using it — example.kt
import mypackage.greet

fun main() {
	println(greet("Ada"))
}
```

Unlike every other topic so far, this one compiles two files together: `kotlinc example.kt mypackage/Helpers.kt -include-runtime -d out.jar`. See [`example.kt`](./example.kt) and [`mypackage/`](./mypackage/) for the full runnable files.

## Common mistakes

1. **Package directory structure not matching the `package` declaration.** By convention (and enforced by most build tools, though not the bare compiler) `package com.example.util` lives at `com/example/util/` — mismatches confuse tooling and other developers even where the compiler itself would tolerate it.
2. **Assuming Kotlin requires one public class per file, as Java does.** A single `.kt` file can contain any number of top-level functions and classes with no such restriction — organize files by cohesive functionality rather than a one-declaration-per-file rule.
3. **Wildcard imports (`import mypackage.*`)** to avoid listing individual names — works, but obscures which specific declarations are actually used; prefer explicit imports (most IDEs auto-manage this).
4. **Forgetting `internal` visibility is module-scoped, not package-scoped.** `internal` makes a declaration visible anywhere within the same compilation module but invisible outside it — different from `private` (file/class-scoped) and from Java's package-private, which is scoped to the package instead.

## Exercise

Using `mypackage/Helpers.kt`'s `greet(name: String)`, write `fun exampleUsage(): String` in `solutions/exercise_1.kt` returning `greet("World")`.

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

## Interview questions

1. **Does Kotlin require one public class per file, like Java?** — No — a `.kt` file may contain multiple top-level functions, classes, and properties with no restriction tying the file name to a single class; file organization is a matter of convention and cohesion, not a compiler rule.
2. **What's the difference between `internal` and `private` visibility in Kotlin?** — `private` (at top level) restricts visibility to the same file; `internal` makes a declaration visible anywhere within the same compilation module (e.g. the same Gradle module or `kotlinc` invocation) but invisible to code outside that module — a middle ground between file-private and fully public that doesn't exist in quite the same form in Java.

---
← [Previous: Files and I/O](../10_files/README.md) | [Next: Testing →](../12_testing/README.md)

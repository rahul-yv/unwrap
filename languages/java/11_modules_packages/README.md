# Modules and Packages

Every Java file belongs to a package (declared with `package name;` at the top, matching its directory path), and `import` brings a class from another package into scope by its fully-qualified name. Since Java 9, modules (`module-info.java`) group packages and declare what they export — most everyday code (and everything in this repo) works at the package level without needing a full module declaration.

## Example

```java
// mypackage/Helpers.java
package mypackage;

public class Helpers {
	public static String greet(String name) {
		return "Hello, " + name + "!";
	}
}
```

```java
// using it — Example.java
import mypackage.Helpers;

public class Example {
	public static void main(String[] args) {
		System.out.println(Helpers.greet("Ada"));
	}
}
```

Unlike every other topic so far, this one needs a real compile step: `javac -d <out> mypackage/Helpers.java`, then `java -cp <out> Example.java`. See [`Example.java`](./Example.java) and [`mypackage/`](./mypackage/) for the full runnable files, and `exercises.md` for the exact commands.

## Common mistakes

1. **Expecting the single-file launcher (`java File.java`) to always resolve a local package import on its own.** Whether it auto-compiles a sibling package depends on the JDK version and exactly how the file is invoked — relying on it is fragile. The robust, version-independent approach is what real Java tooling (Maven/Gradle) does anyway: compile the dependency with `javac` first, then run against that classpath with `java -cp <out> File.java`.
2. **A class not marked `public` when it needs to be used from another package.** No modifier (package-private) restricts visibility to the same package — a common source of "cannot find symbol" confusion when a class works fine within its own package but fails to import elsewhere.
3. **Package directory structure not matching the `package` declaration.** `package com.example.util;` must live at `com/example/util/`, not just anywhere convenient — the compiler enforces this exactly.
4. **Wildcard imports (`import mypackage.*;`)** to avoid listing individual classes — works, but obscures which specific classes are actually used, same downside as in other languages.

## Exercise

Using `mypackage/Helpers.java`'s `greet(String name)`, write `exampleUsage()` in `solutions/Exercise1.java` returning `Helpers.greet("World")`.

Try it yourself first, then check [`solutions/Exercise1.java`](./solutions/Exercise1.java).

## Interview questions

1. **How does Java decide whether a class is visible outside its package?** — By the access modifier on the class: `public` is visible everywhere it's importable, no modifier (package-private) restricts visibility to code in the same package.
2. **What's the difference between a package and a module in Java?** — A package is a namespace grouping related classes (matching a directory structure); a module (`module-info.java`, since Java 9) is a larger unit that explicitly declares which packages it exports and which modules it depends on, enabling stronger encapsulation than packages alone provide.

---
← [Previous: Files and I/O](../10_files/README.md) | [Next: Testing →](../12_testing/README.md)


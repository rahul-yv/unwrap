# Object-Oriented Programming

Kotlin classes are `final` by default (must be marked `open` to allow subclassing) — an explicit opt-in to inheritance, the opposite of Java's default. `data class` auto-generates `equals`/`hashCode`/`toString`/`copy` from its constructor properties. `sealed class`/`sealed interface` restricts subtypes to a known, closed set defined in the same file, letting `when` exhaustively cover every case without an `else` branch.

## Example

```kotlin
open class Animal(val name: String) {
	open fun sound(): String = "..."
}

class Dog(name: String) : Animal(name) {
	override fun sound(): String = "Woof"
}

data class Point(val x: Int, val y: Int)   // equals/hashCode/toString/copy generated

val p1 = Point(1, 2)
val p2 = p1.copy(y = 3)             // Point(x=1, y=3) — a modified copy, p1 unchanged

sealed interface Shape
data class Circle(val radius: Double) : Shape
data class Square(val side: Double) : Shape

fun area(shape: Shape): Double = when (shape) {   // exhaustive: no else needed
	is Circle -> Math.PI * shape.radius * shape.radius
	is Square -> shape.side * shape.side
}
```

See [`example.kt`](./example.kt) for the full runnable file.

## Common mistakes

1. **Forgetting a class must be marked `open` to be subclassed, and a member `open` to be overridden.** Both default to `final` — a deliberate design choice to avoid the "fragile base class" problem of accidentally allowing overrides that weren't designed for; mark only what's intentionally meant to be extended.
2. **Using a regular `class` with hand-written `equals`/`hashCode`/`toString` where `data class` would generate them correctly and concisely** — easy to get boilerplate `equals`/`hashCode` subtly wrong (forgetting a field, inconsistent hash), which `data class` avoids entirely.
3. **Not using `sealed` for a closed set of variants, and reaching for a plain `interface` with an `else -> throw ...` branch in every `when` instead.** `sealed` lets the compiler verify exhaustiveness at compile time — adding a new subtype without updating every `when` becomes a compile error at each incomplete site, not a runtime surprise.
4. **Forgetting `data class`'s generated `equals` is structural (compares properties), not reference-based** — two separately constructed `Point(1, 2)` instances are `==` even though they're different objects, which is usually what's wanted but can surprise code expecting Java-style default reference equality.

## Exercise

Write a `sealed interface Shape` with `data class` variants `Circle(radius: Double)`, `Rectangle(width: Double, height: Double)`, and a function `fun perimeter(shape: Shape): Double` covering both with `when` (no `else`).

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

## Interview questions

1. **Why are Kotlin classes and members `final` by default, unlike Java?** — It's a deliberate design choice: an unplanned override can break invariants the base class relies on (the "fragile base class" problem). Requiring `open` makes inheritance and overriding an explicit design decision by the class author, rather than something any subclass can do unless specifically prevented.
2. **What does `sealed` buy you that a plain `interface` doesn't?** — All direct subtypes of a `sealed` class/interface must be declared in the same file (or module, depending on Kotlin version), so the compiler knows the complete, closed set of possible subtypes. A `when` expression over a sealed type can then be exhaustive without an `else` branch — and if a new subtype is added later, every such `when` that doesn't handle it becomes a compile error, catching the gap immediately instead of at runtime.

---
← [Previous: Collections](../07_collections/README.md) | [Next: Error Handling →](../09_errors/README.md)

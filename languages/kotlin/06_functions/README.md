# Functions

Kotlin functions support default parameter values, named arguments, single-expression bodies (`fun square(x: Int) = x * x`), and lambdas as first-class values (`(Int) -> Int`). A **higher-order function** takes or returns a function; an **extension function** adds a method to an existing type from outside its definition, without subclassing or modifying the original class.

## Example

```kotlin
fun greet(name: String, greeting: String = "Hello") = "$greeting, $name!"

greet("Ada")                      // "Hello, Ada!"
greet("Ada", greeting = "Hi")     // "Hi, Ada!" — named argument

val addFive: (Int) -> Int = { x -> x + 5 }
addFive(3)                         // 8

fun makeAdder(n: Int): (Int) -> Int = { x -> x + n }   // closure over n
val addTen = makeAdder(10)
addTen(5)                          // 15

fun String.shout() = this.uppercase() + "!"   // extension function on String
"hello".shout()                    // "HELLO!"
```

See [`example.kt`](./example.kt) for the full runnable file.

## Common mistakes

1. **Overusing extension functions on types you don't own for logic that's really specific to your domain**, cluttering autocomplete for that type everywhere it's imported. Extension functions are great for genuinely general utility; a one-off helper is often clearer as a regular function.
2. **Forgetting a lambda's last expression is its implicit return value** — `{ x -> x + 1 }` returns `x + 1` without a `return` keyword; using `return` inside a lambda passed to an inline function actually returns from the *enclosing function*, not just the lambda (a "non-local return"), which surprises those expecting block-scoped behavior.
3. **Mixing many optional parameters where a builder or data class would be clearer** — a function with five defaulted parameters called positionally at the call site is hard to read; named arguments help, but sometimes a dedicated parameter object communicates intent better.
4. **Not making single-expression functions actually single-expression.** `fun square(x: Int): Int { return x * x }` works but `fun square(x: Int) = x * x` is the idiomatic, more concise form when the body is one expression.

## Exercise

Write a function `fun makeCounter(): () -> Int` returning a function; each call to the returned function returns an incrementing count starting at 1 (use a closure over a local `var`).

Try it yourself first, then check [`solutions/exercise_1.kt`](./solutions/exercise_1.kt).

## Interview questions

1. **What's an extension function, and what can't it do that a real member function can?** — An extension function (`fun Type.name(...)`) lets you call `receiver.name(...)` syntax on an existing type without modifying its source or subclassing it — resolved statically at compile time based on the declared type. It can't access the type's private members, and it can't be overridden polymorphically the way a real member function can (extension resolution is based on the static type of the expression, not the runtime type).
2. **What does it mean for a lambda to "close over" a variable, and what's a practical use?** — The lambda captures a reference to the variable from its enclosing scope, keeping it alive and allowing the lambda to read (and, since it's a reference, mutate) it across calls even after the enclosing function has returned. A counter closure (`makeCounter`) is the classic example: the returned lambda keeps its own private mutable state via the captured variable.

---
← [Previous: Loops](../05_loops/README.md) | [Next: Collections →](../07_collections/README.md)

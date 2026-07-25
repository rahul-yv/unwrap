# Variables, across 14 languages

How each language declares a variable, whether it's typed statically or dynamically, and what "constant" means.

## Typing model

| Language | Typing | Inference |
|---|---|---|
| Python | Dynamic — a name is bound to an object; the object carries the type, not the name | N/A |
| JavaScript | Dynamic | N/A |
| TypeScript | Static (compile-time only; erased at runtime) | `const age = 25` infers `number` |
| Go | Static | `x := 5` infers; `var x int = 5` is explicit |
| Java | Static | `var` (Java 10+) infers for locals only, not fields/params |
| Rust | Static | `let x = 5` infers; requires `mut` to allow reassignment |
| C | Static, no inference before C23's rarely-used `auto` | — |
| C++ | Static | `auto` (C++11+) infers |
| C# | Static | `var` infers; nullable reference types are opt-in annotations |
| Kotlin | Static | `val`/`var x = 5` infers |
| Swift | Static, sound null safety | `let`/`var x = 5` infers |
| PHP | Dynamic (optional type declarations on function signatures only) | N/A |
| Ruby | Dynamic | N/A |
| Dart | Static, sound null safety | `var`/`final x = 5` infers |

## Reassignment and "constants"

- **Rebinding vs mutation** (Python, JS, Ruby, PHP): assigning a new value to a name never mutates the old object — it just changes what the name points to. A separate mutable object (list, array, dict) can still be mutated in place through its own methods.
- **True compile-time constants**: Rust's `const`, Dart's `const`, Kotlin's `const val` (only for primitives/strings at the top level), Swift's `let` on a value type — all require the value to be known at compile time and make the whole value immutable, not just the binding.
- **Single-assignment, not deep immutability**: Java/Kotlin/Swift/Dart's `final`/`val`/`let` (without `const`) prevent *reassigning the variable*, but if it holds a mutable object (a list, a mutable class instance), the object's contents can still change. This is the most common source of "wait, I thought this was immutable" confusion across the whole matrix.
- **Go's unused-variable rule** is unusual: a declared-but-unused local variable is a hard compile error, not a lint warning — most other languages only warn (or say nothing at all).
- **PHP's `const` vs `define()`**: `const` is resolved at compile time and must be a constant expression; `define()` is a runtime call that can compute its value dynamically — a distinction most other languages don't need since they only have one constant-declaration mechanism.

## Reference vs value semantics for collections

This is the single biggest cross-language gotcha for variables holding a list/array/map:

- **Reference type by default** (mutating a copy mutates the original unless explicitly copied): Python (`list`, `dict`), JavaScript/TypeScript (`Array`, `Object`), Java, C#, Kotlin, PHP objects, Ruby (`Array`, `Hash`), Dart (`List`, `Map`, `Set`).
- **Value type by default** (assignment copies the whole structure): Swift's `Array`/`Dictionary`/`Set` (copy-on-write under the hood, but observably independent), PHP's arrays (also copy-on-write, but arrays specifically — objects are still references), C structs/arrays (a raw memory copy), Go's arrays (not slices — a Go slice is a reference-like view over an underlying array).
- **Explicit copy required in reference-type languages**: `list(original)`/`.copy()` (Python), `[...arr]`/`structuredClone` (JS), `.dup`/`.clone` (Ruby), `List.of(...)`/`.toList()` (Dart), `List.from()` (Kotlin) — every reference-type language needs one of these to get independence.

## Interview-relevant takeaway

The question "does assigning `b = a` give you an independent copy?" has three different correct answers depending on the language and the type: always no (most OO languages' collections), always yes for value types (Swift, C structs), or "it depends whether it's a primitive or a collection" (Python, JS, Ruby, PHP). Getting this wrong in an interview — assuming Python's `list` behaves like Swift's `Array` — is a common, easily-avoided mistake once the underlying model is understood.

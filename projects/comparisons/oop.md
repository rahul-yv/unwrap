# Object-Oriented Programming, across 14 languages

Whether a language has classes at all, how it handles the "no multiple inheritance" problem, and what it does instead of inheritance for code reuse.

## No classes at all

- **Go**: no classes, no inheritance. Structs hold data, methods attach via a receiver, and interfaces are satisfied *implicitly* — no `implements` keyword; if a type has the right methods, it satisfies the interface. Struct embedding gives composition a similar convenience to inheritance without a hierarchy.
- **Rust**: no classes, no inheritance, no subtyping between structs at all. Data lives in `struct`s, behavior in `impl` blocks, shared behavior in `trait`s that types explicitly opt into implementing. Composition (a struct containing another) covers what inheritance does elsewhere.
- **C**: no classes, inheritance, or built-in polymorphism. `struct` groups data; "methods" are ordinary functions taking a struct pointer as their first argument by convention. Polymorphism is hand-built via function-pointer "vtables" — literally what C++ automates.

## Full class-based OOP with single inheritance

Java, C#, C++, Kotlin, Swift (classes specifically), PHP, Ruby, Dart, JavaScript/TypeScript all support single inheritance via `extends`. The interesting differences are in the *defaults* and the *escape hatch* for multiple-inheritance-like reuse:

- **Kotlin's inversion of Java's default**: classes and members are `final` unless explicitly marked `open` — the opposite of Java, where everything is overridable unless marked `final`. A deliberate design choice against the "fragile base class" problem.
- **Swift's two-tier system**: both `struct` (value type) and `class` (reference type) exist as first-class citizens — Swift's own `Array`/`String`/`Int` are all structs. Reach for `class` specifically when you need reference semantics or inheritance; `struct` is the default.

## The multiple-inheritance problem, solved differently everywhere

Every class-based language here needs *some* way to share behavior across unrelated type hierarchies, since (except Python) none allow multiple class inheritance:

| Language | Mechanism | How it works |
|---|---|---|
| Java, C#, Go, Rust, Swift, Dart | multiple interface/protocol/trait implementation | Contract-only (Java/C#/Go/Dart's `interface`, Swift's `protocol`, Rust's `trait`) — no shared implementation unless the language also allows default method bodies |
| PHP, Ruby | traits / modules | `use TraitA, TraitB` (PHP) or `include ModuleA` (Ruby) — actual method *implementations* mixed into the class, not just contracts |
| Dart | mixins (`with`) | Same idea as PHP/Ruby — concrete behavior mixed in without a linear inheritance chain |
| Kotlin | interfaces with default method bodies | Kotlin interfaces *can* provide implementations, blurring the line between "interface" and "trait" |
| Python | true multiple inheritance | The one language here that just allows `class C(A, B):` directly, resolved via MRO (C3 linearization) |

## Data classes: boilerplate elimination for value-carrying types

A near-universal recent addition: a compact way to declare a class that's mostly just data, with `equals`/`hashCode`/`toString`/(sometimes) a copy method generated automatically.

- Java's `record` (16+), C#'s `record` (9+), Kotlin's `data class`, Swift doesn't have a dedicated keyword but structs conforming to `Equatable`/`Hashable` get similar synthesis, Python's `@dataclass`, TypeScript has no dedicated syntax (interfaces/types serve this role structurally instead).

## Closed sets of variants: sealed types + exhaustive matching

Another recent convergent feature: restrict a type's subtypes to a known, closed set declared in the same file/module, so a `switch`/`when`/`match` over them can be checked for exhaustiveness by the compiler.

- Kotlin's `sealed class`/`sealed interface`, Swift's `enum` with associated values (a related but distinct mechanism — one type with closed cases, not a class hierarchy), Dart 3's `sealed class`, Rust's `enum` (arguably the original inspiration for this pattern), TypeScript's discriminated unions (a structural, not nominal, version of the same idea).

## Interview-relevant takeaway

"How does this language solve the multiple-inheritance problem?" is a question with a genuinely different answer in nearly every language here — interfaces-as-contracts-only (Java/Go/Rust/Swift/Dart) vs traits/modules-with-real-implementation (PHP/Ruby) vs true multiple inheritance (Python) vs "there's no inheritance to have a problem with" (Go, Rust, C). Knowing which bucket a language falls into predicts a lot about its idiomatic code-reuse patterns.

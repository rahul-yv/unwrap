# Functions and Closures, across 14 languages

Whether functions are truly first-class, how parameters are passed, and how closures capture their environment.

## Standalone functions vs everything-is-a-method

- **Java, C#, Kotlin, Swift, Dart**: every function lives inside a class/struct — even a "standalone" function is a `static` method somewhere (Kotlin/Swift/Dart soften this with genuinely top-level functions outside any class, unlike Java/C# which require a containing type).
- **Python, JavaScript/TypeScript, Go, Rust, C, C++, PHP, Ruby**: standalone top-level functions are the norm; methods are just functions attached to a type.

## First-class functions: nearly universal, with one holdout

Every language here treats functions as values that can be assigned, passed, and returned — **except pre-lambda-era Java** (fixed since Java 8's lambdas + functional interfaces) and **C**, which has no closures at all: function pointers let you pass a function as a value, but a C function can never capture surrounding local variables the way a closure does elsewhere.

## Closures: what gets captured, and how

- **By reference, mutable, shared** (JS/TS, Python, Ruby, PHP with `use (&$x)`, Kotlin, Swift, Dart, Go): the closure and the enclosing scope share the same variable — mutations are visible on both sides, which is exactly what makes the "counter closure" pattern (`makeCounter()` returning an incrementing function) work identically across nearly every one of these languages.
- **By value, immutable copy** (PHP's default `use ($x)` without `&`, arrow function parameter capture generally): the closure gets a snapshot; later changes to the outer variable aren't seen.
- **Ownership-typed** (Rust): closures come in three distinct flavors depending on *how* they use captured variables — `Fn` (borrows immutably), `FnMut` (borrows mutably), `FnOnce` (takes ownership, callable once) — the compiler infers which one a given closure needs and enforces it at the type level, a level of precision no other language here has.
- **Reference-type object under the hood** (Java's lambdas via functional interfaces, C#'s delegates): a lambda is really an instance of a single-abstract-method interface/delegate type — closures over local variables require the captured variable to be effectively final (Java) or work via compiler-generated capture classes (C#).

## Parameter passing conventions

- **Always by value, but "value" means "the reference" for objects** (Java, Python, JS, Ruby, PHP, C#, Kotlin, Dart): passing a mutable object copies the *reference*, not the object — so mutating the object through the parameter is visible to the caller, but reassigning the parameter itself isn't.
- **Explicit pointer/reference required to mutate the caller's variable** (C, C++, C# with `ref`/`out`/`in`, Swift's `inout`): the default is a true value copy; an explicit annotation opts into letting the callee modify the caller's actual variable.
- **Named/external parameter labels** (Swift's external+internal names, Python/Ruby/PHP/Dart/C#'s named arguments, Kotlin's named arguments): let call sites read like natural language and reorder optional arguments — present in most languages here except Go, Rust, C, C++, and Java (though Java's records/builders approximate it).

## Overloading

Function/method overloading (same name, different parameter types) exists in Java, C#, Kotlin, Swift, C++, Dart — languages with static, nominal typing where the compiler can disambiguate by signature. It's absent from Python, JavaScript/TypeScript, Go, Rust, PHP, Ruby (dynamically typed or, for Go/Rust, deliberately excluded from the language design) — these instead use default/optional parameters, variadic parameters, or distinct function names to cover what overloading provides elsewhere.

## Interview-relevant takeaway

The "write a counter closure" exercise appears (with nearly identical code shape) in nearly every track in this repo — it's the single best litmus test for "does this candidate understand closures capture live references, not snapshots." Rust is the one language where the answer requires an extra layer ("which of `Fn`/`FnMut`/`FnOnce` does this closure need, and why") — a distinctly Rust-flavored version of the same underlying question.

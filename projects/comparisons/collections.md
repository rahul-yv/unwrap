# Collections, across 14 languages

The core question dividing this comparison: does the language give you separate `List`/`Map`/`Set` types, or one flexible structure that plays multiple roles? And is memory managed for you, or by hand?

## Manual memory vs managed collections

- **C** is the outlier: the only built-in collection is the fixed-size array. Growable structures (dynamic arrays, hash maps, linked lists) don't exist in the language or a bundled stdlib — you build them yourself on top of `malloc`/`realloc`/`free`, and getting it wrong is undefined behavior, not a caught exception.
- **C++** solves exactly this gap with the STL: `std::vector`, `std::map`/`std::unordered_map`, `std::set`/`std::unordered_set` — all RAII-managed, no manual `malloc`/`free`.
- Every other language here has garbage-collected (or reference-counted/ARC, for Swift) collections — growable, memory-managed, no manual allocation calls.

## One flexible type vs separate List/Map/Set

- **PHP**: `array` is the *only* built-in composite type — it's simultaneously a list (sequential integer keys) and a map (any key type), unlike every other language in this set.
- **Go**: has both a fixed-size `array` (rarely used directly) and `slice` (a resizable view over an array — what you actually use), plus `map[K]V` as a genuinely separate type — closer to the "separate types" camp, but the array/slice split is unique to Go.
- Everyone else — Python, JS/TS, Java, Rust, C#, Kotlin, Swift, Ruby, Dart — has clearly separate `List`/`Array`/`Vec`, `Map`/`Dictionary`/`Hash`, and `Set` types.

## Mutability: separate types vs one type with a flag

- **Kotlin**: read-only and mutable are *separate interfaces* — `List`/`MutableList`, `Set`/`MutableSet`, `Map`/`MutableMap`. The read-only interface simply doesn't expose mutating methods (the underlying object might still be mutable through another reference holding the mutable type).
- **Swift**: no separate types at all — mutability is controlled entirely by `let`/`var` on the *variable*, and because `Array`/`Dictionary`/`Set` are value types, `let` genuinely makes the whole value immutable (copy-on-write), not just the binding.
- **Rust**: `Vec<T>` is one type; `mut` on the binding controls whether it can be mutated — closer to Swift's model than Kotlin's.
- **Ruby**: one mutable type (`Array`/`Hash`) plus `.freeze` for opt-in immutability on a specific object.
- **Java, C#, Python, JS/TS, PHP, Dart**: collections are mutable reference types by default, with no built-in read-only variant baked into the type system (TypeScript's `readonly T[]` is a compile-time-only annotation, erased at runtime; C# has `IReadOnlyList<T>` as an interface view, similar in spirit to Kotlin's split but less pervasive).

## Ordering guarantees

Insertion-order preservation for the "map" type is more common than you'd expect, but not universal:
- **Preserves insertion order**: Python's `dict` (3.7+), JS/TS's `Map` and `Object` (string keys), C#'s `Dictionary` (in practice, though not contractually guaranteed), PHP's `array`, Ruby's `Hash`, Kotlin's `LinkedHashMap`-backed literals.
- **No order guarantee**: Go's `map`, Java's `HashMap` (use `LinkedHashMap`/`TreeMap` for order), Rust's `HashMap` (use `BTreeMap`/`IndexMap` for order), C++'s `std::unordered_map`, Swift's `Dictionary`, Dart's `Map` (though `LinkedHashMap`, its default literal implementation, does preserve order — an implementation detail worth knowing, not a hard `Map` contract).

## Lazy vs eager transformation chains

Most languages here provide `.map`/`.filter`/`.reduce`-style operations, but they differ on whether chaining them builds intermediate collections at every step:
- **Lazy by default or via an opt-in wrapper**: Rust's iterators (compile-time-resolved, zero-cost), Kotlin's `Sequence`, Swift's `.lazy`, Java's `Stream`, Python's generator expressions/`itertools`.
- **Eager by default**: JS/TS's `Array.map`/`.filter` (each call builds a new array immediately), Go (no built-in functional methods on slices at all — manual loops, or a third-party library), PHP's `array_map`/`array_filter`, Ruby's `Enumerable` methods (eager unless `.lazy` is explicitly called), Dart's `Iterable` methods (actually lazy by default — `.map`/`.where` don't run until consumed, closer to Rust/Kotlin than to JS).

## Interview-relevant takeaway

"Is `list2 = list1` an independent copy?" (covered in the variables comparison) and "does chaining `.map().filter()` allocate an intermediate array at every step?" are the two questions that trip people up moving between these languages — the answer to the second one specifically separates Rust/Kotlin/Swift/Dart (lazy, efficient chains) from JS/PHP/Ruby (eager by default, `.lazy` opt-in where available at all).

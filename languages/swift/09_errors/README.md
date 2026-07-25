# Error Handling

Swift's error handling sits between checked and unchecked: a `throws` function must declare it in its signature (checked, at the boundary), but the compiler doesn't require callers to catch specific error types — `try`/`catch` (or `try?`/`try!`) at the call site handles whatever conforms to `Error` was thrown. `Result<Success, Failure>` models an outcome explicitly in the return type for cases where deferred or stored error handling is clearer than propagation.

## Example

```swift
enum MathError: Error, Equatable {
	case divisionByZero
}

func divide(_ a: Int, _ b: Int) throws -> Int {
	if b == 0 { throw MathError.divisionByZero }
	return a / b
}

let result: Int
do {
	result = try divide(10, 0)
} catch MathError.divisionByZero {
	result = -1
} catch {
	result = -2   // catches any other Error
}

let safe = try? divide(10, 2)          // Optional<Int> — nil if it throws
let forced = try! divide(10, 2)         // crashes the program if it throws

func safeDivide(_ a: Int, _ b: Int) -> Result<Int, MathError> {
	b == 0 ? .failure(.divisionByZero) : .success(a / b)
}
```

See [`example.swift`](./example.swift) for the full runnable file.

## Common mistakes

1. **Using `try!` outside of situations where failure is genuinely impossible.** `try!` bypasses error handling entirely and crashes the program if the call throws — appropriate only when the specific inputs guarantee success (e.g. a hardcoded, known-valid regex), not as a shortcut to avoid writing `do`/`catch`.
2. **Catching every error with a bare `catch` when a specific `MathError.divisionByZero` case was actually expected**, masking unrelated errors that happen to conform to `Error` — catch the specific case(s) you're prepared to handle, and let (or explicitly handle) the rest.
3. **Forgetting `throws` must be declared on the function signature.** Unlike Kotlin/Java's unchecked exceptions, Swift requires marking a function `throws` if it (or anything it calls without handling) can throw — this is enforced at compile time, so a call to a throwing function must be preceded by `try` (or `try?`/`try!`).
4. **Reaching for a thrown error for expected, routine outcomes** (like "value not found") instead of an optional or `Result` — errors and `throws` communicate "this operation can genuinely fail," while an optional return communicates "absence is a normal, expected outcome."

## Exercise

Write a function `func safeParseInt(_ s: String) -> Result<Int, Error>` that parses `s` as an `Int`, returning `.success` or `.failure` with a custom error instead of crashing on invalid input.

Try it yourself first, then check [`solutions/exercise_1.swift`](./solutions/exercise_1.swift).

## Interview questions

1. **How does Swift's error handling differ from unchecked exceptions (like Kotlin's) and fully checked exceptions (like older Java's)?** — A `throws` function must declare it in its signature (checked, at the function boundary — callers know what *can* throw), but the compiler doesn't require distinguishing or exhaustively catching every specific error type the way Java's checked exceptions historically did — a single `catch` (or `try?`) can handle "some `Error` was thrown" without enumerating every possible case.
2. **What's the difference between `try?` and `try!`?** — `try?` converts a throwing call into an optional: `nil` if it threw, the wrapped value otherwise — used when the caller wants to treat failure as an absent value rather than propagating or handling the error. `try!` asserts the call will succeed and crashes the program immediately if it throws — appropriate only when failure is truly not expected to be possible for the given inputs.

---
← [Previous: OOP](../08_oop/README.md) | [Next: Files and I/O →](../10_files/README.md)

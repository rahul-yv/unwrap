# Error Handling, across 14 languages

How each language signals and handles failure — the split between "errors as values" and "errors as exceptions" is the single biggest divide in this comparison.

## The two families

**Errors as values** (no exceptions at all, or exceptions reserved for truly unrecoverable bugs):
- **Go**: functions return `(result, error)`; the caller checks `if err != nil` explicitly. `panic`/`recover` exist but are for programming bugs, not routine control flow.
- **Rust**: `Result<T, E>` and `Option<T>` are ordinary enum types; the `?` operator propagates a failure to the caller in one character. `panic!` is for unrecoverable bugs and isn't meant to be caught as normal control flow.
- **C**: a return code (`-1`, `NULL`, nonzero) by convention only — nothing forces the caller to check it. `errno` supplements this for many stdlib functions.

**Exceptions** (a `throw`/`try`/`catch` mechanism, with stack unwinding):
- Python, JavaScript/TypeScript, Java, C#, Kotlin, Swift, PHP, Ruby, Dart, C++ all use some form of `try`/`catch`.

## Checked vs unchecked exceptions

This distinction only really exists in a few languages:
- **Java** has true checked exceptions: a method throwing a checked exception (subclass of `Exception`, not `RuntimeException`) must either catch it or declare `throws` — enforced by the compiler.
- **Swift** is a hybrid: `throws` must be declared on the function signature (checked, at the boundary), but the compiler doesn't require catching *specific* error types the way Java does — a bare `catch` handles anything conforming to `Error`.
- Every other exception-based language here (JS/TS, C#, Kotlin, PHP, Ruby, Dart, C++) has fully **unchecked** exceptions — nothing in the function signature tells you what it might throw; that information lives only in documentation (or, for Kotlin/Swift, an explicit `Result<T>` return type used deliberately instead of `throws`).

## "Don't catch everything" convention

Nearly every exception-based language draws a line between exceptions meant to be caught (application-level, expected failures) and exceptions/errors that generally shouldn't be silently swallowed (programming bugs, unrecoverable conditions):

| Language | "Catch this" | "Don't casually catch this" |
|---|---|---|
| Python | `Exception` subclasses | `BaseException`-only things like `KeyboardInterrupt`, `SystemExit` |
| PHP | `Exception` | `Error` (`TypeError`, `DivisionByZeroError`) |
| Ruby | `StandardError` | `Exception` itself (covers `SystemExit`, `NoMemoryError`) |
| Dart | `Exception` | `Error` (`RangeError`, `TypeError`) |
| Java | checked `Exception`s | `Error` (`OutOfMemoryError`) |

The underlying idea is identical across all five: separate "this is a normal, anticipated failure mode of the operation" from "something is fundamentally broken and swallowing it will hide a bug."

## Resource cleanup alongside error handling

- **`finally`**: present in every exception-based language here and always runs regardless of whether the `try` block succeeded, returned early, or threw — the universal mechanism for "must run no matter what."
- **Deterministic cleanup on top of `finally`**: C#'s `using`, Java's try-with-resources (`AutoCloseable`), Python's `with` (context managers), Go's `defer`, Rust's RAII (`Drop` trait, no explicit syntax needed), C++'s RAII (destructors) — each is a more targeted, less error-prone alternative to manually writing `finally { resource.close(); }` everywhere a resource is acquired.

## Interview-relevant takeaway

"Should you catch `Exception`/`Throwable`/`Error` broadly?" has the same answer in every one of these languages: no, catch the most specific type you're actually prepared to handle, because a broad catch silently swallows bugs alongside expected failures. The mechanism differs (Go's `if err != nil`, Rust's `?`, Java's checked exceptions, Python's `except SpecificError`), but the underlying discipline — narrow, deliberate handling over blanket catch-alls — is identical everywhere.

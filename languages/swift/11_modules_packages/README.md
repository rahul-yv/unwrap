# Modules and Packages

Swift organizes code into **modules** — the unit of code distribution and access control, typically one per framework/library/app target, usually managed by the Swift Package Manager (`Package.swift`). Within a module, every file can see every other file's non-`private` declarations automatically — there's no `import` needed between files in the same module (unlike Kotlin/Java packages), only between different modules (`import Foundation`).

## Example

```swift
// Helpers.swift
func greet(_ name: String) -> String {
	"Hello, \(name)!"
}
```

```swift
// using it — main.swift, same module, no import needed
print(greet("Ada"))
```

Unlike every other topic so far, this one compiles two files together: `swiftc main.swift mypackage/Helpers.swift -o out && ./out`. Note the entry point is named `main.swift`, not `example.swift` — when compiling multiple files, only a file literally named `main.swift` may contain top-level executable statements (see [`solutions/exercise_1.swift`](./solutions/exercise_1.swift) — actually `solutions/main.swift`, same constraint). See [`main.swift`](./main.swift) and [`mypackage/`](./mypackage/) for the full runnable files.

## Common mistakes

1. **Adding an unnecessary `import` between files in the same module.** Swift files in the same module see each other's internal declarations automatically — `import` is for pulling in a *different* module (a framework, another package target, or the standard library's `Foundation`), not for cross-file visibility within one module.
2. **Marking everything `public` by default**, exposing implementation details across module boundaries unnecessarily. The default access level (`internal`) is already visible everywhere within the module — reach for `public`/`open` only for the module's actual external API.
3. **Forgetting only `main.swift` may hold top-level executable code when compiling multiple files.** Every other file in a multi-file `swiftc` compilation must contain only declarations (functions, types, etc.) — a stray top-level statement in a non-`main.swift` file is a compile error.
4. **Confusing `private` and `fileprivate`.** `private` restricts visibility to the enclosing declaration (and extensions of it in the same file); `fileprivate` restricts visibility to the whole file — useful when a helper needs to be shared between an extension and its main type declaration but nothing else in the module should see it.

## Exercise

Using `mypackage/Helpers.swift`'s `greet(_:)`, write `func exampleUsage() -> String` in `solutions/main.swift` returning `greet("World")`.

Try it yourself first, then check [`solutions/main.swift`](./solutions/main.swift).

## Interview questions

1. **Why doesn't Swift require `import` between files in the same module, unlike Kotlin's or Java's package imports?** — A module is the actual unit of compilation and access control in Swift; all files compiled together into one module share visibility of each other's `internal`-or-higher declarations automatically. `import` is reserved for bringing in declarations from a genuinely separate module (a different framework, package, or the standard library), which the compiler doesn't have visibility into without it.
2. **What's the difference between `private` and `fileprivate` access levels?** — `private` limits visibility to the enclosing declaration and its extensions within the same file; `fileprivate` limits visibility to anything in the same file, regardless of which type or top-level scope it's in — useful when splitting a type's implementation across multiple `extension` blocks in one file, where `private` members need to be shared between them.

---
← [Previous: Files and I/O](../10_files/README.md) | [Next: Testing →](../12_testing/README.md)

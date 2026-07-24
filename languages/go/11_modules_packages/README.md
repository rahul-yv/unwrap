# Modules and Packages

Every Go file belongs to a package (declared with `package name` at the top); a directory is one package, and its exported names (starting with an **uppercase** letter) are visible to importers — there's no separate `export` keyword, capitalization *is* the visibility rule. A module (`go.mod`, created with `go mod init`) groups packages and declares the import path they're reachable at.

## Example

```go
// mypackage/helpers.go
package mypackage

func Greet(name string) string {   // uppercase Greet: exported, visible outside the package
	return "Hello, " + name + "!"
}

func helper() string {              // lowercase helper: unexported, package-private
	return "internal only"
}
```

```go
// using it
import "unwrap/go/11_modules_packages/mypackage"

mypackage.Greet("Ada")   // "Hello, Ada!"
// mypackage.helper()     // compile error: helper is not exported
```

See [`example.go`](./example.go) and [`mypackage/`](./mypackage/) for the full runnable files.

## Common mistakes

1. **Expecting a separate `export` keyword.** Go uses capitalization: `Greet` (uppercase first letter) is exported, `greet`/`helper` (lowercase) is package-private. This applies to functions, types, struct fields, and constants alike.
2. **Forgetting a new module needs `go mod init <module-path>`** before local package imports resolve — without a `go.mod`, `go run` only works for self-contained single files with no local imports.
3. **Creating an import cycle** (package A imports package B, which imports package A) — Go's compiler rejects this outright as a compile error, unlike some languages where it might silently produce a partially-initialized module.
4. **Putting unrelated functionality into one large package** instead of splitting by responsibility — Go's convention favors small, focused packages named for what they provide (`http`, `json`, `time`), not generic dumping grounds like `utils`.

## Exercise

Using `mypackage/helpers.go`'s `Greet(name string) string`, write `ExampleUsage() string` in `solutions/exercise_1.go` that calls `mypackage.Greet("World")`.

Try it yourself first, then check [`solutions/exercise_1.go`](./solutions/exercise_1.go).

## Interview questions

1. **How does Go decide whether a name is exported?** — Purely by the first letter's case: uppercase is exported (visible to other packages), lowercase is unexported (package-private) — no keyword involved.
2. **What's the difference between a package and a module in Go?** — A package is a directory of `.go` files sharing a `package` declaration; a module (defined by `go.mod`) is a versioned collection of packages with a declared import path root, and is the unit Go's dependency management operates on.

---
← [Previous: Files and I/O](../10_files/README.md) | [Next: Testing →](../12_testing/README.md)

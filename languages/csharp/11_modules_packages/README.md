# Modules and Packages

C# organizes code at three levels: **namespaces** (logical grouping of types — `System`, `System.Collections.Generic`), **assemblies** (the compiled unit — a `.dll` or `.exe` produced from a project), and **NuGet packages** (the package-manager distribution format, added with `dotnet add package`). You bring a namespace's types into scope with `using`. Modern C# adds **file-scoped namespaces** (`namespace Foo;` with no braces, applying to the whole file) and **global usings** (`global using`, so a namespace is available across the whole project without repeating it).

## Example

```csharp
namespace MyPackage;   // file-scoped namespace (C# 10) — applies to the whole file

public static class Greeter {
	public static string Greet(string name) => $"Hello, {name}!";
}
```

```csharp
// using it (in another file, same project)
using MyPackage;

string result = Greeter.Greet("Ada");   // "Hello, Ada!"
```

The example in this folder demonstrates the same idea within a single file (a namespace defined and used together), since these lessons run as single-file apps. See [`example.cs`](./example.cs).

## Common mistakes

1. **`public` vs `internal` confusion.** A type/member is accessible everywhere it's referenced if `public`, but `internal` (the default for top-level types) restricts it to the same assembly — a common surprise when a type "works internally" but can't be used from another project that references the assembly.
2. **Not using file-scoped namespaces** (`namespace Foo;`) in new code — the older block form (`namespace Foo { ... }`) adds a layer of indentation for no benefit when a file has a single namespace, which is the norm.
3. **Repeating the same `using` directives in every file** instead of a `global using` (in one place) for namespaces used throughout the project — global usings reduce boilerplate for ubiquitous namespaces.
4. **Confusing an assembly with a namespace.** A namespace is a naming scope (can span multiple assemblies); an assembly is a deployment/compilation unit (a `.dll`). One assembly can contain many namespaces, and one namespace can be spread across assemblies — they're orthogonal.

## Exercise

Define a namespace `MyPackage` containing a `public static class Greeter` with `Greet(string name)`, then call `MyPackage.Greeter.Greet("World")` from `example_usage()`, returning the result.

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

## Interview questions

1. **What's the difference between a namespace and an assembly in C#?** — A namespace is a compile-time logical grouping of type names (to organize code and avoid name collisions), and can span multiple files and even multiple assemblies; an assembly is the physical compiled output unit (a `.dll` or `.exe`) that's deployed and versioned, and is also the boundary for `internal` accessibility. They're independent concepts — one assembly can hold many namespaces.
2. **What does the `internal` access modifier mean, and when is it the right choice?** — `internal` makes a type or member accessible only within the same assembly (it's the default for top-level types). It's the right choice for implementation details you want to share across your own project's code but not expose as public API to other assemblies that reference yours — keeping the public surface small and changeable.

---
← [Previous: Files and I/O](../10_files/README.md) | [Next: Testing →](../12_testing/README.md)

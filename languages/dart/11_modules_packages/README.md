# Modules and Packages

Dart files import each other with `import 'relative/path.dart'` (files within the same package) or `import 'package:name/path.dart'` (a published or local dependency, resolved via `pubspec.yaml`). Real Dart/Flutter projects are organized as **packages** (a directory with a `pubspec.yaml`), and `pub` (via `dart pub get`) resolves dependencies declared there — similar in spirit to npm/Cargo/Bundler. Every top-level declaration is public by default; prefixing a name with `_` makes it library-private (visible only within the same file, or the same `library` if using the `part`/`part of` directives to split one library across files).

## Example

```dart
// mypackage/helpers.dart
String greet(String name) => "Hello, $name!";
```

```dart
// using it — example.dart
import "mypackage/helpers.dart";

void main() {
	print(greet("Ada"));
}
```

See [`example.dart`](./example.dart) and [`mypackage/`](./mypackage/) for the full runnable files.

## Common mistakes

1. **Using a relative import path that breaks if the file is moved**, instead of a `package:` import for anything outside the immediate local directory structure. Within one package, relative imports (`import '../models/user.dart'`) are conventional and fine; `package:` imports are for referencing a genuinely separate package (including your own package's `lib/` directory from outside it, or an external dependency).
2. **Not prefixing implementation-detail declarations with `_` (library-private)**, leaving internal helpers importable and usable from outside the library where they were never meant to be part of the public API — Dart has no separate `private`/`internal` keyword; the underscore prefix on the name itself is the entire privacy mechanism.
3. **Importing an entire library when only a couple of names are needed, without `show`/`hide` to document intent.** `import 'package:some_lib/some_lib.dart' show specificFunction;` makes clear exactly what's being used from that library, useful in large codebases; unrestricted imports work but convey less about actual usage.
4. **Two imported libraries exporting a name with the same identifier, causing a collision** — resolved with an import prefix (`import 'package:foo/foo.dart' as foo;`, then `foo.someName`), which is also useful generally for namespacing a library's many exports under one recognizable prefix.

## Exercise

Using `mypackage/helpers.dart`'s `greet`, write `String exampleUsage()` in `solutions/exercise_1.dart` returning `greet("World")`.

Try it yourself first, then check [`solutions/exercise_1.dart`](./solutions/exercise_1.dart).

## Interview questions

1. **What's the difference between a relative import and a `package:` import in Dart?** — A relative import (`import 'helpers.dart'` or `import '../models/user.dart'`) resolves the path relative to the importing file's own location. A `package:` import (`import 'package:my_package/helpers.dart'`) resolves through the package resolution system (backed by `pubspec.yaml` and the `.dart_tool/package_config.json` it generates), used for referencing your own package's `lib/` directory from elsewhere, or any external dependency.
2. **How does Dart implement access control (public/private) without dedicated `public`/`private` keywords?** — Any top-level declaration (or class member) whose name starts with an underscore (`_helper`, `_InternalState`) is private to its *library* (typically one file, unless split across files with `part`/`part of`) — invisible when imported from another library. Everything else is public by default. This is a simple naming convention enforced by the compiler, rather than a separate access-modifier keyword system.

---
← [Previous: Files and I/O](../10_files/README.md) | [Next: Testing →](../12_testing/README.md)

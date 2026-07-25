# Modules and Packages, across 14 languages

How each language groups code into units, controls visibility, and manages external dependencies.

## No built-in module system at all

- **C**: headers (`.h`, declarations) paired with source files (`.c`, implementation), joined by `#include` at the preprocessor level and by the linker afterward. `static` at file scope is the closest thing to "private."
- **PHP**: `require`/`require_once` just execute another file inline at runtime — no compile-time module concept. Namespaces (`namespace App\Helpers;`) exist purely to avoid name collisions, layered on top of the same "just run this file" mechanism.

Both of these languages compensate with an ecosystem-standard tool doing the real work: PHP's Composer (PSR-4 autoloading) removes the need for manual `require` chains in practice, even though the language itself has nothing structural.

## Capitalization or a keyword decides visibility

- **Go** is the standout: there's no `export`/`public` keyword at all — an identifier starting with an **uppercase** letter is exported, lowercase is package-private. Capitalization *is* the entire visibility mechanism.
- Everyone else uses an explicit modifier: `pub` (Rust), `public`/`private`/`internal` (C#, Java, Kotlin), `_prefix` (Python's convention, Dart's enforced-by-compiler private, Ruby's `private` keyword for methods).

## File vs directory vs compilation-unit as "the module"

- **Python**: a module is one `.py` file; a package is a directory with `__init__.py` (or a namespace package without one).
- **Go**: a package is a *directory* (potentially many files); a module (`go.mod`) groups packages under one import path.
- **Rust**: a module (`mod`) is a logical grouping (inline or a separate file); a *crate* is the actual compilation unit; a *package* (`Cargo.toml`) can contain multiple crates. Three distinct nested concepts, more layers than most languages here.
- **Java, C#, Kotlin**: package/namespace is a logical grouping matching (by convention, and for Java by requirement) the directory structure; the JVM/CLR class file or assembly is the actual compiled unit.
- **Swift**: the *module* is the actual unit — typically one per app/framework target — and, unusually, every file within one module sees every other file's internal-or-higher declarations automatically, with no `import` needed between files in the same module at all.

## Same-module visibility without `import`

Swift's "no import needed within a module" is echoed, differently, in a couple of other languages:
- **Kotlin's `internal`**: visible anywhere in the same compilation module (not just the same file/package) — broader than Java's package-private, narrower than public.
- **C#'s `internal`**: same idea, visible anywhere in the same assembly.

Contrast with Go, Java, Python, Ruby, Dart, PHP — where even code in the same overall project still needs an explicit `import`/`require`/`use` between files unless it's in the literal same file.

## Package manager landscape

Every language here has a de facto standard package manager, but their relationship to the language itself varies:
- **Built into the toolchain**: Cargo (Rust), Go modules (`go mod`), `dart pub`, npm (Node/JS/TS) — the language's own CLI *is* the package manager.
- **Separate but universal**: Composer (PHP), Bundler/RubyGems (Ruby), Maven/Gradle (Java), NuGet (C#) — not part of the language spec, but so ubiquitous that "the language's package manager" unambiguously refers to one of them.
- **pip** (Python) sits in between — part of the standard distribution but historically fragmented (pip/poetry/conda/uv all coexist).

## Interview-relevant takeaway

"How does this language decide what's exported from a module?" has a genuinely different mechanism in nearly every language — Go's capitalization convention is the one people are most often surprised by coming from any other language, since it's the only one where visibility is inferred from naming rather than declared with a keyword.

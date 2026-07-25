# Testing, across 14 languages

Whether testing is built into the toolchain, ships as a stdlib module, or requires a genuinely external framework — and how that shaped every track's `12_testing` lesson.

## Built into the toolchain — zero setup

- **Go**: `go test` picks up `xxx_test.go` files with `func TestXxx(t *testing.T)` automatically, no framework, no dependency.
- **Rust**: `#[test]` functions inside a `#[cfg(test)] mod tests` block, run with `cargo test` (or even `rustc --test` directly without Cargo). Compiled only when testing, so it doesn't bloat the release binary.

These two are the gold standard for "test support with zero external dependency and zero configuration" — the language's own build tool *is* the test runner.

## Full framework, but bundled in the standard library

- **Python**: `unittest` ships in stdlib. The ecosystem mostly prefers `pytest` (plain `assert`, better fixtures) but `unittest` alone is enough for a dependency-free lesson.

## Full framework, external dependency required (but a de facto standard)

- **Java**: JUnit 5 — not part of the JDK; real projects pull it in via Maven/Gradle. The lesson uses the standalone console jar directly to avoid needing a build tool.
- **C#**: xUnit/NUnit/MSTest — none are part of the BCL; all need a dedicated test project and NuGet packages.

## No framework at all — hand-rolled harness is the norm

- **C**: no built-in test framework; `assert()` exists but aborts on first failure with no summary — poor for a real test suite. Real C projects add Unity/CMocka/Check, or (as this repo does for a dependency-free lesson) a small macro-based harness that keeps running and reports a pass/fail count.
- **Swift, Kotlin, PHP, Ruby, Dart, C++**: each has a *real* framework in its ecosystem (XCTest/Swift Testing, kotlin.test/Kotest, PHPUnit, RSpec/Minitest, package:test, GoogleTest/Catch2) — but every one of them requires a build tool or package manager setup beyond a single file. Every one of these tracks therefore builds the same hand-rolled pattern independently: a small class/struct with a `check(condition, name)` method that records pass/fail and keeps going, plus a `summary()` that returns a nonzero exit code if anything failed.

## The convergent hand-rolled harness shape

Despite being written independently across seven different languages (C, C++, Kotlin, Swift, PHP, Ruby, Dart), the "no framework available in a single file" harness converges on an almost identical shape everywhere:

```
run += 1
if condition: print PASS, else: print FAIL and failed += 1
...
print summary: "{passed}/{run} passed"
exit(failed == 0 ? 0 : 1)
```

This isn't a coincidence — it's the minimum viable feature set any test framework needs: independent checks that don't stop the whole run on first failure, a human-readable summary, and a machine-readable (exit code) result for CI. Every real framework (JUnit, pytest, RSpec, `go test`) is this same idea with far more polish (discovery, fixtures, matchers, parameterization) layered on top.

## Interview-relevant takeaway

"Why does a test runner need to report a nonzero exit code, and why shouldn't it stop at the first failure?" — both properties recur as explicit interview-question content across nearly every track in this repo, because they're the two properties that separate "runs some checks" from "is actually usable by CI": CI only knows pass/fail from the exit code, and a single early-abort hides every other failure in the same run.

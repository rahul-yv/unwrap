# Testing

C# has a mature testing ecosystem — **xUnit**, **NUnit**, and **MSTest** are the three main frameworks, run via `dotnet test` in a dedicated test project. They provide attribute-based test discovery (`[Fact]`/`[Test]`), rich assertions (`Assert.Equal(expected, actual)`), fixtures, and parameterized tests (`[Theory]`/`[TestCase]`). Because those need a separate test project and NuGet packages, this lesson uses a small self-contained harness to stay runnable as a single file — but the shape (named checks, a summary, a nonzero exit on failure) mirrors what any framework does.

## Example (xUnit shape — what a real test looks like)

```csharp
public class MathTests {
	[Fact]
	public void AddsPositiveNumbers() {
		Assert.Equal(5, Add(2, 3));
	}

	[Theory]
	[InlineData(0, 0, 0)]
	[InlineData(-1, 1, 0)]
	public void AddsVariousInputs(int a, int b, int expected) {
		Assert.Equal(expected, Add(a, b));
	}
}
```

The runnable [`example.cs`](./example.cs) uses a minimal harness (a `Check` helper that records results and exits nonzero on failure) so it runs as a single file with `dotnet run`.

## Common mistakes

1. **A test runner (or `Main`) that returns `0` regardless of failures.** `dotnet test` and CI use the exit code to decide pass/fail; a harness that always succeeds hides failing tests. Return nonzero when any check fails.
2. **Testing implementation details instead of behavior** — assert on the method's output for given inputs, not on private state or internal call order that a refactor would change.
3. **Not using `[Theory]`/`[InlineData]` (or the equivalent) for parameterized cases** — copy-pasting near-identical `[Fact]` methods for each input is more code and harder to extend than one data-driven test.
4. **Not testing edge cases** — empty collections, zero, negative numbers, `null` — the discipline is the same in every language.

## Exercise

Using the harness pattern in `example.cs`, write checks that `Add(0, 0) == 0` and `Add(-1, 1) == 0`, returning a nonzero exit code if any check fails.

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

## Interview questions

1. **What's the difference between `[Fact]` and `[Theory]` in xUnit?** — `[Fact]` marks a single, parameterless test method (one specific case); `[Theory]` marks a data-driven test that runs once per data set supplied by `[InlineData]` (or other data-source attributes), so one method covers many input/expected pairs without duplication.
2. **Why must a test process return a nonzero exit code on failure?** — CI pipelines and `dotnet test` determine success by the process exit code; if the test binary exits `0` regardless of assertion results, failing tests are reported as passing and broken code slips through automation undetected.

---
← [Previous: Modules and Packages](../11_modules_packages/README.md) | Next: Networking (coming soon)

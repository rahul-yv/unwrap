# Testing

JUnit 5 (Jupiter) is the de facto standard testing framework for Java — unlike Python/JS/Go, the JDK itself ships no test runner, so real projects pull it in via Maven/Gradle. This lesson uses the `junit-platform-console-standalone` jar directly (no build tool needed) so the example stays runnable with just `javac`/`java`, the same as every other topic.

## Example

```java
// code under test
public class Example {
	public static int add(int a, int b) {
		return a + b;
	}
}
```

```java
// ExampleTest.java
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class ExampleTest {
	@Test
	void addsPositiveNumbers() {
		assertEquals(5, Example.add(2, 3));
	}

	@Test
	void addsNegativeNumbers() {
		assertEquals(-5, Example.add(-2, -3));
	}
}
```

Run with (downloading the console-standalone jar once, cached locally after):

```sh
curl -sL -o /tmp/junit-console.jar "https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.11.3/junit-platform-console-standalone-1.11.3.jar"
javac -cp /tmp/junit-console.jar Example.java ExampleTest.java
java -jar /tmp/junit-console.jar execute -cp . --select-class ExampleTest
```

See [`Example.java`](./Example.java) and [`ExampleTest.java`](./ExampleTest.java) for the full files.

## Common mistakes

1. **Testing implementation details instead of behavior** — same pitfall as any language; assert on what the method returns for given input, not on internal call patterns.
2. **One `@Test` method covering many unrelated behaviors.** If it fails, you can't tell which assertion broke without reading the stack trace closely — one behavior per `@Test` method, named for what it checks.
3. **Not testing edge cases** — empty input, zero, negative numbers, `null` — only the happy path misses the bugs that actually show up in production.
4. **Forgetting `@Test` methods (and the class itself) must be visible to the test runner** — package-private (no modifier) is fine within the same package, but a common mistake when refactoring is accidentally marking a test method `private`, which JUnit silently can't invoke.

## Exercise

Given `Example.java`'s `add(int a, int b)`, write JUnit tests checking `add(0, 0) == 0` and `add(-1, 1) == 0`.

Try it yourself first, then check [`solutions/Exercise1Test.java`](./solutions/Exercise1Test.java).

## Interview questions

1. **What's the difference between a unit test and an integration test?** — A unit test isolates one method/class (dependencies mocked/stubbed); an integration test exercises multiple real components together (e.g. a method that actually hits a database).
2. **What does `@Test` do, and how does JUnit discover test methods?** — It's an annotation marking a method as a test case; JUnit's platform scans classes for methods annotated `@Test` (via reflection) and invokes each one independently, reporting pass/fail per method.

---
← [Previous: Modules and Packages](../11_modules_packages/README.md) | Next: Networking (coming soon)

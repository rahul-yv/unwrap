# Testing

Ruby's standard library ships `Test::Unit`-style testing historically, but modern Ruby projects use **RSpec** or **Minitest** (Minitest ships with Ruby itself, unlike RSpec which is a gem). For a dependency-free example matching every other topic's plain-`ruby` setup, this lesson uses a small hand-rolled harness — enough to show the essential shape of any test runner: run independent checks, keep going after a failure, and exit with a nonzero code if anything failed so CI can detect it.

## Example

```ruby
class TestRunner
  def initialize
    @run = 0
    @failed = 0
  end

  def check(condition, name)
    @run += 1
    if condition
      puts "PASS: #{name}"
    else
      @failed += 1
      puts "FAIL: #{name}"
    end
  end

  def summary
    puts "#{@run - @failed}/#{@run} passed"
    @failed.zero? ? 0 : 1
  end
end

def add(a, b) = a + b

t = TestRunner.new
t.check(add(2, 3) == 5, "adds positive numbers")
t.check(add(-2, -3) == -5, "adds negative numbers")
exit(t.summary)
```

See [`example.rb`](./example.rb) for the full runnable file.

## Common mistakes

1. **Exiting with `0` (or not calling `exit` with a code at all) regardless of test results.** CI decides pass/fail from the process exit code — a script that always exits `0` reports "green" even when checks failed; call `exit(code)` with a nonzero code when any check fails.
2. **Stopping at the first failure with a bare `raise` on assertion.** Raising immediately ends the script at the first failing condition, so you learn about exactly one failure per run; a real harness records each result and continues, giving a full picture of what passed and failed.
3. **Testing implementation details instead of behavior** — assert on a method's observable output for given inputs, not on internal state or call sequences a harmless refactor would change.
4. **Not testing edge cases** — empty arrays, zero, negative numbers, `nil`, boundary values — the same discipline as any language.

## Exercise

Using the `TestRunner` pattern, write checks that `add(0, 0) == 0` and `add(-1, 1) == 0`, exiting with the runner's summary exit code.

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

## Interview questions

1. **Why does a test runner's exit code matter?** — CI systems and build tools determine whether a test step passed by checking the process's exit code; a script that always returns success (`0`) regardless of individual test outcomes would let failing tests slip through automation undetected.
2. **What do RSpec/Minitest add over a hand-rolled harness?** — Test discovery via file naming/directory conventions (no manual list of checks to run), rich matcher/assertion DSLs with descriptive failure messages, fixtures and setup/teardown hooks, shared examples for reducing duplication across similar tests, and structured output formats for CI integration — conveniences a minimal harness omits but that matter at scale.

---
← [Previous: Modules and Packages](../11_modules_packages/README.md) | [Next: Networking →](../13_networking/README.md)

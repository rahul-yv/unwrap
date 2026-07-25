# Error Handling

Ruby uses `begin`/`rescue`/`ensure`/`else` — all exceptions descend from `Exception`, but application code should rescue `StandardError` (or its subclasses) specifically, not `Exception` itself, since `Exception` also covers things like `SystemExit` and `NoMemoryError` that generally shouldn't be caught and silently handled. `raise` re-raises the current exception with no arguments inside a `rescue` block, useful for logging before propagating.

## Example

```ruby
class InvalidAmountError < StandardError; end

def withdraw(amount)
  raise InvalidAmountError, "amount cannot be negative" if amount < 0
  amount
end

result = begin
  withdraw(-5)
rescue InvalidAmountError => e
  -1
ensure
  # always runs
end

def divide(a, b)
  a / b
rescue ZeroDivisionError
  -1
end

begin
  risky_operation
rescue SomeError => e
  log(e)
  raise   # re-raise the same exception after logging
end
```

See [`example.rb`](./example.rb) for the full runnable file.

## Common mistakes

1. **Rescuing bare `Exception` instead of `StandardError` (or a specific subclass).** `rescue Exception` (or a bare `rescue` inside a `begin` — actually `rescue` alone defaults to `StandardError`, which is usually right) catches things like `SystemExit`/`Interrupt`/`NoMemoryError` too, which generally shouldn't be silently handled — swallowing a `SystemExit` can even prevent a program from exiting when it's told to.
2. **Catching a broad exception type when a specific one was actually expected**, masking unrelated bugs — a `NoMethodError` from a genuine programming mistake gets silently treated the same as the anticipated failure.
3. **Not defining custom exception subclasses for distinct failure categories**, instead raising a generic `RuntimeError` with only a message string — callers can't `rescue` selectively by type and have to parse the message text to distinguish failure cases.
4. **Forgetting a method's body can rescue directly without an explicit `begin`/`end`** (as in the `divide` example) — `def method; ...; rescue Error; ...; end` is equivalent to wrapping the whole body in `begin`/`rescue`/`end`, and is the more idiomatic form when the rescue covers the entire method body.

## Exercise

Write a method `def safe_parse_int(s)` that parses `s` as an integer, returning `nil` if it isn't a valid integer string (rescuing `ArgumentError` from `Integer(s)`, which raises rather than returning a sentinel the way `to_i` does).

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

## Interview questions

1. **Why should application code rescue `StandardError` rather than `Exception`?** — `Exception` is the root of Ruby's entire exception hierarchy, including things like `SystemExit`, `Interrupt` (Ctrl-C), and `NoMemoryError` — conditions that generally represent the program being told to stop or being unable to continue safely, not application-level failures meant to be handled and recovered from. `StandardError` (and its subclasses, which is what `raise CustomError` typically descends from) covers the errors application code actually expects and wants to catch; a bare `rescue` with no class defaults to `StandardError` for exactly this reason.
2. **What does calling `raise` with no arguments inside a `rescue` block do?** — It re-raises the exception currently being handled, unchanged — useful for logging or performing cleanup before letting the original error continue propagating up the call stack, without losing the original exception's type, message, or backtrace (which a fresh `raise SomeError, "message"` would discard).

---
← [Previous: OOP](../08_oop/README.md) | [Next: Files and I/O →](../10_files/README.md)

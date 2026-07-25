# Data Types

Ruby's core types are `Integer`, `Float`, `String`, `Symbol` (an immutable, interned name like `:active`, cheaper to compare than a `String`), `true`/`false`, `nil`, `Array`, and `Hash`. There's no dedicated `Optional`/nullable-type syntax — any variable can hold `nil`, and `&.` (the "safe navigation" operator) calls a method only if the receiver isn't `nil`, returning `nil` otherwise instead of raising `NoMethodError`.

## Example

```ruby
i = 42
f = 3.14
s = "hello"
sym = :active
flag = true
n = nil

name = nil
length = name&.length          # nil — &. short-circuits instead of raising
length ||= 0                    # 0 — ||= assigns only if the left side is falsy (nil or false)

ratio = 3 / 2        # 1 — integer division truncates when both operands are Integer
exact = 3.0 / 2       # 1.5 — floating-point division

big = 10_000_000_000_000_000_000   # Integer has arbitrary precision — no overflow
```

See [`example.rb`](./example.rb) for the full runnable file.

## Common mistakes

1. **Forgetting integer division truncates.** `3 / 2` is `1`, not `1.5`, when both operands are `Integer` — convert at least one operand to `Float` (`3.0 / 2` or `3 / 2.0`) for a fractional result.
2. **Using a `String` where a `Symbol` would be more appropriate** (as a hash key, an enum-like fixed value, or a method argument selecting a mode) — symbols are immutable and interned (every `:active` is the same object in memory), making comparison faster and intent clearer than an arbitrary mutable string.
3. **Calling a method on a value that might be `nil` without `&.` or an explicit `nil` check**, risking `NoMethodError: undefined method for nil`. `user&.name&.upcase` short-circuits to `nil` at the first `nil` link, rather than crashing.
4. **Confusing `||=` with a plain `=` when the left side could legitimately be `false`.** `flag ||= true` reassigns `flag` to `true` even if it was already explicitly `false`, since `||=` treats `false` the same as `nil` (both are falsy) — use an explicit `flag = true if flag.nil?` when `false` needs to be preserved as a real value.

## Exercise

Write a method `def safe_length(s)` that returns the string's length, or `0` if it's `nil`, using `&.` and `||`.

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

## Interview questions

1. **What's the difference between a `String` and a `Symbol` in Ruby?** — A `String` is mutable and each literal creates a new object; a `Symbol` (`:name`) is immutable and interned — every occurrence of `:name` in a program refers to the same object, making equality checks (`==`) and hashing faster. Symbols are the idiomatic choice for fixed, semantic identifiers (hash keys, method names, enum-like values) where mutability is never needed.
2. **What does the safe navigation operator (`&.`) do?** — `receiver&.method` calls `method` on `receiver` only if `receiver` is not `nil`; if `receiver` is `nil`, the whole expression short-circuits to `nil` instead of raising `NoMethodError`. It's most useful for chains (`a&.b&.c`), where any link being `nil` should make the whole chain `nil` rather than crash.

---
← [Previous: Variables](../01_variables/README.md) | [Next: Operators →](../03_operators/README.md)

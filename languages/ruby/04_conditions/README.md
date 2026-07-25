# Conditionals

`if`/`elsif`/`else` and `case`/`when` are both **expressions** in Ruby — they evaluate to a value, so `x = if cond then a else b end` works directly, and the last statement of an `if`/`case` is its return value. `case` matches using `===` (the "case equality" operator), which different classes define differently — `Range#===` checks membership, `Class#===` checks `is_a?`, `Regexp#===` checks match — making `case`/`when` far more flexible than a simple switch on equality.

## Example

```ruby
age = 20
category = if age < 13 then "child" elsif age < 20 then "teen" else "adult" end

x = 5
description = case
              when x < 0 then "negative"
              when x == 0 then "zero"
              when x.even? then "positive even"
              else "positive odd"
              end

def describe(value)
  case value
  when Integer then "an Integer: #{value}"
  when String then "a String of length #{value.length}"
  when nil then "nil"
  else "something else"
  end
end

def grade(score)
  case score
  when 90.. then "A"
  when 80...90 then "B"
  else "F"
  end
end
```

See [`example.rb`](./example.rb) for the full runnable file.

## Common mistakes

1. **Forgetting `case`/`when` uses `===`, not `==`.** `when Integer` matches via `Integer === value` (which checks `value.is_a?(Integer)`), not literal equality — this is what lets `case` match by class, range membership, or regex pattern, but it can surprise someone expecting simple `==` semantics from a `switch`-like construct in another language.
2. **Not taking advantage of `if`/`case` being expressions.** Assigning inside each branch (`if cond; x = a; else; x = b; end`) works but is more verbose and error-prone (easy to forget a branch) than `x = if cond then a else b end`, which guarantees every branch produces a value for `x`.
3. **Using `unless ... else ...`** — `unless` reads naturally for a single negative condition (`unless valid? ... end`), but adding an `else` branch to `unless` inverts the reading order confusingly; prefer `if !cond ... else ... end` or restructure once an `else` is needed.
4. **Comparing floating-point values for exact equality in a condition** (`if x == 0.3`) — the same rounding-error trap as any language; compare against a small tolerance instead when the value comes from computation rather than a literal.

## Exercise

Write a method `def grade(score)` returning `"A"` for 90+, `"B"` for 80-89, `"C"` for 70-79, and `"F"` otherwise, using `case`/`when` with ranges.

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

## Interview questions

1. **Why does `case`/`when` use `===` instead of `==`?** — `===` ("case equality") is a method each class can define to mean whatever "matches" means for that class: `Range#===` checks membership, `Class#===` checks whether the value is an instance, `Regexp#===` checks pattern match, and the default (for most objects) falls back to `==`. This makes one `case` expression able to dispatch on type, range, or pattern — much more expressive than a plain `switch` limited to value equality.
2. **Why does it matter that `if`/`case` are expressions in Ruby?** — It lets a value be produced directly from a conditional (`x = if cond then a else b end`) rather than requiring a mutable variable pre-declared and assigned inside each branch — reducing a common class of bugs where a branch forgets to set the variable, and making intent (the whole point of the conditional is to produce this value) clearer at the call site.

---
← [Previous: Operators](../03_operators/README.md) | [Next: Loops →](../05_loops/README.md)

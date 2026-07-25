# Operators

Ruby has the usual arithmetic, comparison, and logical operators, plus a spaceship operator (`<=>`, returns -1/0/1, used to implement `Comparable`), ranges (`1..10` inclusive, `1...10` exclusive), and operator overloading via defining methods named after the operator (`def +(other)`). Most operators in Ruby are actually method calls in disguise — `a + b` is `a.+(b)`.

## Example

```ruby
sum = 3 + 4
remainder = 10 % 3

in_range = (1..10).include?(5)     # true — inclusive range
not_in_range = !(1..10).include?(15)

a = true
b = false
puts a && b   # false
puts a || b   # true

x = nil
y = x || -1    # -1 — || returns the first truthy operand

class Point
  attr_reader :x, :y
  def initialize(x, y) = (@x, @y = x, y)

  def +(other) = Point.new(x + other.x, y + other.y)   # operator overloading
  def ==(other) = other.is_a?(Point) && x == other.x && y == other.y
end
p = Point.new(1, 2) + Point.new(3, 4)   # Point(4, 6)
```

See [`example.rb`](./example.rb) for the full runnable file.

## Common mistakes

1. **Confusing `..` (inclusive range) with `...` (exclusive range).** `1..5` includes `5`; `1...5` doesn't. Off-by-one errors follow from mixing them up, especially when using a range to slice an array (`arr[0...arr.length]` vs `arr[0..arr.length]`, where the latter is off by one).
2. **Overloading an operator (`def +`) in a way that doesn't match the operator's expected meaning** — `+` should mean "combine two things of the same conceptual kind," not something unrelated; Ruby lets you define almost any operator method, but readability suffers if the semantics don't match convention.
3. **Forgetting `&&`/`||` short-circuit but `and`/`or` (the English-word variants) have much lower precedence than `&&`/`||`**, which can silently change what an expression parses as when mixed with assignment (`result = a or b` assigns just `a` to `result`, not `a or b`, because `=` binds tighter than `or`). Prefer `&&`/`||` for boolean logic in expressions; reserve `and`/`or` for control-flow-style statement separation, if at all.
4. **Not implementing `<=>` (and including `Comparable`) when a class needs to support `<`, `>`, `<=`, `>=`, `==`, and `.sort` — instead manually defining each comparison method separately**, duplicating logic that a single `<=>` implementation plus `include Comparable` provides automatically.

## Exercise

Write a method `def clamp(value, min, max)` that returns `value` clamped to the `[min, max]` range.

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

## Interview questions

1. **What does the spaceship operator (`<=>`) do, and why does `Comparable` rely on it?** — It returns `-1`, `0`, or `1` for less-than, equal, and greater-than respectively (or `nil` if the comparison is undefined between the two objects). `include Comparable` in a class that defines `<=>` automatically derives `<`, `<=`, `==`, `>=`, `>`, and `.between?` from that one method — implement `<=>` once instead of every comparison operator individually.
2. **Why are operators like `+`/`==` "just methods" in Ruby, and what does that enable?** — `a + b` is syntactic sugar for `a.+(b)` — the `+` operator is dispatched as a regular method call on `a`'s class. This means any class can define its own `+`/`==`/`<=>`/etc. methods to give its instances natural operator syntax, and existing built-in classes could even have their operators reopened (monkey-patched), though that's generally discouraged outside of well-scoped refinements.

---
← [Previous: Data Types](../02_datatypes/README.md) | [Next: Conditionals →](../04_conditions/README.md)

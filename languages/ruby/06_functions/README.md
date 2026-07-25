# Functions

Ruby methods (`def`) support default parameters, keyword arguments (`def greet(name:, greeting: "Hello")`), splat (`*args`) and double-splat (`**kwargs`) for variadic parameters, and implicit return — the last evaluated expression is returned automatically, though `return` can be used explicitly (required for an early return). Blocks (`{ }` or `do...end`), `Proc`, and `Lambda` are Ruby's closures; a lambda checks its argument count strictly and `return` inside it returns only from the lambda, while a `Proc`'s `return` returns from the enclosing method.

## Example

```ruby
def greet(name, greeting: "Hello")
  "#{greeting}, #{name}!"    # implicit return: last expression's value
end

greet("Ada")                       # "Hello, Ada!"
greet("Ada", greeting: "Hi")        # "Hi, Ada!" — keyword argument

def sum(*numbers)
  numbers.sum
end
sum(1, 2, 3)                        # 6 — splat collects variadic args into an array

add_five = ->(x) { x + 5 }          # lambda
add_five.call(3)                    # 8, or add_five.(3), or add_five[3]

def make_counter
  count = 0
  -> { count += 1 }                 # closure over count, returned as a lambda
end
```

See [`example.rb`](./example.rb) for the full runnable file.

## Common mistakes

1. **Confusing `Proc.new`/blocks with `lambda`s and their different `return` semantics.** A `lambda`'s `return` exits only the lambda, behaving like a normal method; a `Proc`'s `return` exits the *enclosing method* entirely, which can produce a `LocalJumpError` if that enclosing method has already returned — this is a genuinely different, easy-to-miss behavior, not just a syntax variation.
2. **Not using keyword arguments for methods with several parameters of the same type**, where positional arguments become ambiguous at the call site (`create_user("Ada", "Lovelace", true, false)` — what do the booleans mean?) — keyword arguments (`create_user(first: "Ada", last: "Lovelace", admin: true, active: false)`) make each argument self-documenting.
3. **Relying on implicit return when an early exit was actually intended.** The last expression is returned automatically, which is idiomatic for the common case, but a conditional early exit still needs an explicit `return` — forgetting it means execution falls through to whatever expression comes next.
4. **Overusing splat/double-splat (`*args`, `**kwargs`) for methods that could have an explicit, well-named signature** — flexible variadic methods are harder to understand at the call site and lose the self-documentation that named parameters provide; reach for them when the parameter count is genuinely open-ended, not as a default habit.

## Exercise

Write a method `def make_counter` returning a lambda; each call to the returned lambda returns an incrementing count starting at 1 (use a closure over a local variable).

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

## Interview questions

1. **What's the key difference between a `Proc` and a `lambda` in Ruby?** — A `lambda` checks its argument count strictly (raises `ArgumentError` on a mismatch, like a normal method) and its `return` only exits the lambda itself; a `Proc` is lenient about argument count (missing arguments become `nil`, extra ones are ignored) and its `return` exits the *enclosing method* where the `Proc` was defined — a much more surprising and rarely-intended behavior if not understood.
2. **What does it mean for `make_counter` to return a closure, and how does the counter persist across calls?** — The returned lambda captures (closes over) the local variable `count` from `make_counter`'s scope; even after `make_counter` itself returns, that captured variable stays alive as long as the lambda referencing it exists. Each call to the lambda reads and mutates that same captured `count`, which is how the counter accumulates state between calls without any external storage.

---
← [Previous: Loops](../05_loops/README.md) | Next: Collections (coming soon)

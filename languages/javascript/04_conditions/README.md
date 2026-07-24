# Conditionals

JavaScript has `if`/`else if`/`else`, a ternary expression (`cond ? a : b`), and `switch`. `switch` uses `===` comparison and falls through to the next case unless you `break` — a frequent source of bugs.

## Example

```javascript
const score = 85;
let grade;
if (score >= 90) {
  grade = "A";
} else if (score >= 80) {
  grade = "B";
} else {
  grade = "C";
}

const label = score >= 60 ? "pass" : "fail";

switch (true) {
  case score >= 90:
    grade = "A";
    break;
  case score >= 80:
    grade = "B";
    break;
  default:
    grade = "C";
}
```

See [`example.js`](./example.js) for the full runnable file.

## Common mistakes

1. **Forgetting `break` in a `switch` case**, causing execution to "fall through" into the next case unintentionally. Every case needs `break` (or `return`) unless the fallthrough is deliberate and commented as such.
2. **Using `switch (true)` with range conditions without realizing case order matters** — cases are checked top to bottom, so a broader condition placed before a narrower one will shadow it.
3. **Checking truthiness of values that are legitimately `0` or `""`** with a plain `if (value)` — same pitfall as the `||` operator; be explicit (`if (value !== null)`) when zero/empty-string are valid.
4. **Nesting ternaries until they're unreadable.** One level of `cond ? a : b` is fine; a chain of nested ternaries should usually become an `if`/`else if` chain instead.

## Exercise

Write `grade(score)` returning `"A"` for `score >= 90`, `"B"` for `>= 80`, `"C"` for `>= 70`, and `"F"` otherwise.

Try it yourself first, then check [`solutions/exercise_1.js`](./solutions/exercise_1.js).

## Interview questions

1. **Why is forgetting `break` in a `switch` a common bug?** — `switch` falls through to subsequent cases by default until it hits a `break`, unlike some languages where each case is isolated — easy to forget, especially coming from languages where cases don't fall through.
2. **What does `switch (true)` accomplish?** — Lets you write range/boolean conditions as `case` expressions (since each is compared against `true` with `===`), effectively turning `switch` into an `if`/`else if` chain with different syntax.

---
← [Previous: Operators](../03_operators/README.md) | [Next: Loops →](../05_loops/README.md)

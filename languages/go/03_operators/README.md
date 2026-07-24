# Operators

Go's operators are mostly familiar (`+ - * / % == != < > && || !`), with a few notable omissions and additions: no ternary operator (Go deliberately left it out — use an `if`/`else` or a helper function), no `**` for exponentiation (use `math.Pow`), and the comma-ok idiom for checking success alongside a value (map lookups, type assertions, channel receives).

## Example

```go
q := 7 / 2   // 3 — integer division truncates toward zero
r := 7 % 2   // 1

m := map[string]int{"a": 1}
value, ok := m["a"]   // comma-ok: value=1, ok=true
missing, ok2 := m["z"] // value=0 (zero value), ok=false

// no ternary — this is the idiomatic replacement:
label := "fail"
if q > 0 {
	label = "pass"
}
```

See [`example.go`](./example.go) for the full runnable file.

## Common mistakes

1. **Expecting `/` on two integers to produce a float.** `7 / 2` is `3` (integer division, truncated toward zero) when both operands are integers; at least one must be a `float64` for a fractional result (`7.0 / 2`).
2. **Reading a map value without checking the comma-ok result**, then being unable to distinguish "key present with zero value" from "key absent" — `m["missing"]` silently returns the zero value instead of erroring.
3. **Looking for a ternary operator and reaching for an awkward workaround** (e.g. a single-expression trick) instead of just writing the `if`/`else` — Go intentionally omits `?:` to keep conditional logic explicit and readable.
4. **Forgetting Go has no operator overloading.** `+` on two custom struct types is a compile error; there's no way to make `a + b` work for your own types the way some languages allow.

## Exercise

Write `divide(a, b int) (int, bool)` that returns `a / b` and `true`, or `0` and `false` if `b` is zero — using the comma-ok convention instead of panicking on division by zero.

Try it yourself first, then check [`solutions/exercise_1.go`](./solutions/exercise_1.go).

## Interview questions

1. **Why doesn't Go have a ternary operator?** — A deliberate simplicity choice by the language designers: they consider `if`/`else` clearer to read than a `?:` expression, and Go generally favors one obvious way to write something over multiple terse alternatives.
2. **What is the "comma-ok" idiom, and where does it show up?** — A two-value return where the second value reports success/presence (`value, ok := m[key]` for maps, `value, ok := x.(SomeType)` for type assertions, `value, ok := <-channel` for channel receives) — it lets you distinguish "got the zero value" from "the operation didn't succeed."

---
← [Previous: Data Types](../02_datatypes/README.md) | [Next: Conditionals →](../04_conditions/README.md)

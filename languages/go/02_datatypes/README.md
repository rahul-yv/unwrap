# Data Types

Go has explicit-width numeric types (`int8`...`int64`, `uint8`...`uint64`, `float32`/`float64`), `string` (immutable, UTF-8 bytes), `bool`, and `rune` (an alias for `int32`, representing a single Unicode code point — not a byte). `int`/`uint` are platform-width (32 or 64 bit depending on the target) and the default choice unless you specifically need a fixed width.

## Example

```go
var n int = 10          // platform-width int
var small int8 = 127     // explicit 8-bit, range -128..127
var pi float64 = 3.14159
var name string = "Ada"
var ok bool = true

for i, r := range "héllo" {
	fmt.Println(i, r) // ranging over a string yields (byte index, rune), not (index, byte)
}

fmt.Println(len("héllo")) // 6 — byte length, not character count (é is 2 bytes in UTF-8)
```

See [`example.go`](./example.go) for the full runnable file.

## Common mistakes

1. **Assuming `len(s)` on a string returns the character count.** It returns the *byte* length; multi-byte UTF-8 characters (like `é`) make byte length exceed character count. Use `utf8.RuneCountInString(s)` (from `unicode/utf8`) for character count, or `range` over the string for rune-by-rune iteration.
2. **Indexing a string with `s[i]` expecting a character.** `s[i]` returns a single *byte* (`uint8`), not a rune — for multi-byte characters this gives a fragment of the UTF-8 encoding, not the character.
3. **Integer overflow silently wrapping instead of erroring.** `var x int8 = 127; x++` wraps to `-128` with no runtime error — Go does not check for overflow by default; choose a wide-enough type or check bounds explicitly if it matters.
4. **Mixing numeric types in an expression without explicit conversion.** `var a int32 = 5; var b int64 = 10; a + b` is a compile error — Go requires an explicit conversion (`int64(a) + b`) even between numeric types that other languages would silently coerce.

## Exercise

Write `countRunes(s string) int` returning the number of Unicode characters (not bytes) in `s`, using `range` or `utf8.RuneCountInString`.

Try it yourself first, then check [`solutions/exercise_1.go`](./solutions/exercise_1.go).

## Interview questions

1. **Why does `len("héllo")` return `6` instead of `5`?** — Go strings are UTF-8 byte sequences; `len` counts bytes, and `é` encodes to 2 bytes in UTF-8, so the 5-character string is 6 bytes long.
2. **Why doesn't Go allow implicit conversion between numeric types (e.g. `int32` + `int64`)?** — A deliberate design choice to make width/precision changes visible in the code rather than silently happening — implicit numeric coercion is a common source of subtle bugs (overflow, precision loss) in other languages.

---
← [Previous: Variables](../01_variables/README.md) | [Next: Operators →](../03_operators/README.md)

# Collections

Go has fixed-size arrays (`[5]int`, size is part of the type — rarely used directly), slices (`[]int`, a resizable view over an underlying array — what you use almost everywhere), and maps (`map[K]V`, unordered). Structs (`type Point struct { X, Y int }`) are Go's way of grouping fields — there's no class keyword.

## Example

```go
nums := []int{1, 2, 3}
nums = append(nums, 4)          // may or may not reallocate, depending on capacity

m := map[string]int{"a": 1}
m["b"] = 2
value, ok := m["a"]              // comma-ok, see 03_operators

type Point struct {
	X, Y int
}
p := Point{X: 3, Y: 4}
```

See [`example.go`](./example.go) for the full runnable file.

## Common mistakes

1. **Assuming two slices from `append` are always independent.** If the original slice has spare capacity, `append` writes into the *same* underlying array and returns a slice sharing it — mutating one can silently affect the other until a reallocation happens. Use `copy()` into a fresh slice when true independence is required.
2. **Reading from a `nil` map, expecting a panic.** Reading a `nil` map returns the zero value (like a normal empty map) — but *writing* to a `nil` map panics. Always `make(map[K]V)` before writing.
3. **Comparing slices or maps with `==`.** Go only allows `==` on arrays (fixed size, comparable element type) and structs with comparable fields — slices and maps aren't comparable with `==` (except to `nil`); use `reflect.DeepEqual` or a manual loop.
4. **Passing a large struct by value repeatedly** when a pointer would avoid the copy — Go copies structs on assignment/parameter passing by default (no implicit reference semantics like classes in other languages); use `*Point` when the struct is large or needs to be mutated by the callee.

## Exercise

Write `wordCounts(words []string) map[string]int` returning a map from each word to its occurrence count.

Try it yourself first, then check [`solutions/exercise_1.go`](./solutions/exercise_1.go).

## Interview questions

1. **What's the difference between an array and a slice in Go?** — An array's length is part of its type (`[5]int` and `[10]int` are different types) and it's copied by value; a slice is a small header (pointer, length, capacity) pointing at an underlying array, making it cheap to pass around and able to grow via `append`.
2. **Why does writing to a `nil` map panic while reading doesn't?** — Reading is defined to return the zero value for any key on a `nil` map (nothing to look up, safe default); writing needs an actual underlying hash table to insert into, which a `nil` map doesn't have — `make()` allocates it.

---
← [Previous: Functions](../06_functions/README.md) | [Next: OOP →](../08_oop/README.md)

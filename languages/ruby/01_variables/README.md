# Variables

Ruby is dynamically typed with no declaration keyword — assigning to a lowercase-starting name creates a local variable. Constants start with an uppercase letter (`MAX_RETRIES = 3`) — Ruby only warns (doesn't error) if a constant is reassigned, unlike languages that enforce true immutability for constants. Everything in Ruby is an object, including integers and `nil` — there are no separate "primitive" types.

## Example

```ruby
age = 25              # dynamically typed, no keyword needed
name = "Ada"
age = age + 1

MAX_RETRIES = 3        # constant by convention (uppercase first letter)

point = [3, 4]         # arrays are objects, assigned by reference
copy = point.dup       # an explicit shallow copy — without .dup, copy and point alias the same array
copy[0] = 99
# point is still [3, 4]
```

See [`example.rb`](./example.rb) for the full runnable file.

## Common mistakes

1. **Assuming `copy = point` makes an independent copy of an array/hash/string.** Ruby's mutable objects (arrays, hashes, most strings) are assigned by reference — `copy = point` makes `copy` and `point` refer to the *same* object; mutating one mutates the other. Use `.dup` (shallow copy) or `.clone` (shallow copy, also copies frozen status) when independence is needed.
2. **Reassigning a constant and being surprised it's only a warning, not an error.** `MAX_RETRIES = 3; MAX_RETRIES = 4` prints a warning but still reassigns — constants in Ruby are a naming convention enforced loosely, not a hard immutability guarantee (freeze the object itself with `.freeze` for a real immutability guarantee on its contents).
3. **Not knowing every value is an object, including integers.** `5.class` returns `Integer`, and `5.even?` is a valid method call — there's no boxed/unboxed distinction to worry about, unlike languages with a primitive/object split.
4. **Using a global variable (`$name`) for state that should be local or instance-scoped** — globals are rarely appropriate in idiomatic Ruby and tightly couple code across the entire program.

## Exercise

Write a method `def swap(a, b)` that returns `[b, a]`.

Try it yourself first, then check [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

## Interview questions

1. **Are Ruby arrays/hashes passed and assigned by value or by reference?** — By reference — assigning one variable to another, or passing an array/hash to a method, shares the same underlying object; mutating it through either reference affects both. `.dup`/`.clone` create an explicit shallow copy when independence is needed.
2. **What does it mean that "everything is an object" in Ruby?** — Integers, strings, `nil`, `true`/`false`, even classes themselves are all objects with methods you can call on them (`5.class`, `nil.nil?`, `String.ancestors`) — there's no distinction between primitive types and objects the way Java/C# have; this is why method-chaining and duck-typing feel so natural throughout Ruby.

---
← Previous: (start) | [Next: Data Types →](../02_datatypes/README.md)

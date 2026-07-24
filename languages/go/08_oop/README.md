# Object-Oriented Programming

Go has no classes and no inheritance. Instead: structs hold data, methods attach behavior to a type via a receiver, interfaces are satisfied *implicitly* (no `implements` keyword — if a type has the right methods, it satisfies the interface), and struct embedding gives composition a similar convenience to inheritance without the hierarchy.

## Example

```go
type Animal struct {
	Name string
}

type Speaker interface {
	Speak() string
}

type Dog struct {
	Animal          // embedding: Dog gets Animal's fields/methods "for free"
}

func (d Dog) Speak() string {
	return d.Name + " says Woof"    // Name comes from the embedded Animal
}

func (a Animal) Describe() string {
	return "an animal named " + a.Name
}

var s Speaker = Dog{Animal{Name: "Rex"}}   // Dog satisfies Speaker implicitly — no `implements`
```

See [`example.go`](./example.go) for the full runnable file.

## Common mistakes

1. **Looking for `implements` or `extends` keywords.** There are none — a type satisfies an interface automatically if it has the required methods; this is checked structurally, at compile time, wherever the interface is used.
2. **Using a value receiver `(d Dog)` when the method needs to mutate the struct**, then being confused why the mutation doesn't stick — a value receiver operates on a *copy*; use a pointer receiver `(d *Dog)` to mutate the original.
3. **Mixing value and pointer receivers inconsistently on the same type.** If any method needs a pointer receiver, it's conventional (and often required for interface satisfaction) to make all of that type's methods pointer receivers.
4. **Assuming embedding is inheritance.** Embedding promotes the embedded type's fields/methods to the outer struct for convenient access, but there's no polymorphic dispatch through the embedded type — the outer struct doesn't become a subtype of the embedded one in the OOP sense.

## Exercise

Define a `Rectangle` struct with `Width, Height float64`, a method `Area() float64`, and a method `Equals(other Rectangle) bool` comparing by width and height.

Try it yourself first, then check [`solutions/exercise_1.go`](./solutions/exercise_1.go).

## Interview questions

1. **How does Go achieve polymorphism without classes or inheritance?** — Through interfaces satisfied implicitly: any type with the right method set can be used wherever that interface is expected, so different concrete types can be handled uniformly by code that only depends on the interface.
2. **What's the difference between a value receiver and a pointer receiver?** — A value receiver `(t T)` operates on a copy of the value (mutations don't persist to the caller's original); a pointer receiver `(t *T)` operates on the original via its address, and is required when the method needs to mutate the receiver or avoid copying a large struct.

---
← [Previous: Collections](../07_collections/README.md) | [Next: Error Handling →](../09_errors/README.md)

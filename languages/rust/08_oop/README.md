# Object-Oriented Programming

Rust has no classes or inheritance. Data lives in `struct`s; behavior is attached via `impl` blocks; shared behavior across types is expressed with `trait`s (similar to interfaces), which types opt into implementing. There's no subtyping between structs — composition (a struct containing another) and traits cover what inheritance does in class-based languages.

## Example

```rust
trait Speaker {
	fn speak(&self) -> String;
}

struct Dog {
	name: String,
}

impl Speaker for Dog {
	fn speak(&self) -> String {
		format!("{} says Woof", self.name)
	}
}

impl Dog {
	fn new(name: &str) -> Self {
		Dog { name: name.to_string() }
	}
}

let dog = Dog::new("Rex");
println!("{}", dog.speak());

// trait objects: different concrete types, handled uniformly through the trait
let speakers: Vec<Box<dyn Speaker>> = vec![Box::new(Dog::new("Rex"))];
```

See [`example.rs`](./example.rs) for the full runnable file.

## Common mistakes

1. **Looking for `class`/`extends` and trying to force struct "inheritance".** There isn't any — reach for composition (embed one struct in another) or traits (shared behavior contract) instead of trying to replicate a class hierarchy.
2. **Deriving `#[derive(PartialEq)]` and expecting it without adding the attribute.** Unlike some languages, Rust structs don't get `==` comparison for free — `#[derive(PartialEq, Debug, Clone)]` above a struct opts into the common trait implementations mechanically, rather than writing them by hand.
3. **Forgetting `&self` vs `self` vs `&mut self` in a method signature matter.** `&self` borrows immutably (read-only), `&mut self` borrows mutably (can modify fields), `self` takes ownership (consumes the instance, common for builder-style "final step" methods) — picking the wrong one is a frequent early friction point.
4. **Using `dyn Trait` (dynamic dispatch, a trait object) by default** when generic `impl Trait`/`<T: Trait>` (static dispatch, monomorphized at compile time) would be faster and is usually what's needed — `dyn Trait` earns its keep specifically when a single collection needs to hold multiple different concrete types behind the same trait.

## Exercise

Define a `struct Rectangle { width: f64, height: f64 }`, implement a method `area(&self) -> f64`, and derive `PartialEq` so two rectangles with equal fields compare equal.

Try it yourself first, then check [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

## Interview questions

1. **How does Rust achieve polymorphism without class inheritance?** — Through traits: any type implementing a trait can be used wherever that trait is expected, either statically (generics, resolved and inlined at compile time) or dynamically (`dyn Trait` / `Box<dyn Trait>`, resolved via a vtable at runtime) — no shared base class required.
2. **What's the difference between `&self`, `&mut self`, and `self` as a method's receiver?** — `&self` borrows the instance immutably (read-only access), `&mut self` borrows it mutably (can modify fields), `self` takes ownership outright (the instance is consumed — common for methods that transform and return a new value, like builder patterns' final step).

---
← [Previous: Collections](../07_collections/README.md) | [Next: Error Handling →](../09_errors/README.md)

# Object-Oriented Programming

C# is fully class-based: `class` with access modifiers (`public`/`private`/`protected`/`internal`), single inheritance plus multiple `interface` implementation, `abstract` classes, `virtual`/`override` for polymorphism, and **properties** (`{ get; set; }`) as the idiomatic way to expose data with encapsulation. **Records** (`record`, C# 9+) are concise immutable reference types with value-based equality generated automatically — ideal for data-carrying types.

## Example

```csharp
public interface ISpeaker {
	string Speak();
}

public abstract class Animal(string name) : ISpeaker {   // primary constructor (C# 12)
	public string Name { get; } = name;                   // read-only property
	public abstract string Speak();
}

public class Dog(string name) : Animal(name) {
	public override string Speak() => $"{Name} says Woof";
}

// a record: value-based equality, immutability, and ToString generated for you
public record Point(int X, int Y);

var p1 = new Point(3, 4);
var p2 = new Point(3, 4);
bool equal = p1 == p2;   // true — records compare by value, not reference
```

See [`example.cs`](./example.cs) for the full runnable file.

## Common mistakes

1. **Exposing public fields instead of properties.** A public field can't later add validation, change notification, or become computed without breaking the API; a property (`{ get; set; }`) looks the same to callers but preserves that flexibility — properties are the C# convention for exposed data.
2. **Writing a full class with manual `Equals`/`GetHashCode`/`ToString` for a simple data holder.** A `record` generates value-based equality, a good `GetHashCode`, `ToString`, and a deconstructor automatically — far less boilerplate for immutable data types.
3. **Forgetting `override` (or misusing `new`) when overriding a virtual method.** A method only overrides a base `virtual`/`abstract` method if marked `override`; writing `new` (or nothing) instead creates a separate method that hides the base one, breaking polymorphism — the compiler warns, so heed it.
4. **Comparing reference-type objects with `==` expecting value equality.** For a normal `class`, `==` compares references (identity) unless overloaded; records override it to compare by value. Know which kind you have before relying on `==`.

## Exercise

Define an `interface IShape` with `double Area()`, then a `record Rectangle(double Width, double Height) : IShape` implementing `Area()` as `Width * Height`. Confirm two equal rectangles compare `==` (record value equality).

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

## Interview questions

1. **What does a `record` give you that a regular `class` doesn't?** — Automatically generated value-based equality (`Equals`/`==`/`GetHashCode` compare by the record's members, not by reference), a readable `ToString`, a deconstructor, and `with`-expression support for non-destructive copies — plus records are immutable by default (init-only members). It's the concise choice for data-carrying types where identity is defined by content.
2. **Why prefer properties over public fields in C#?** — A property is a member-access-compatible pair of accessor methods, so exposing one lets you later add validation, lazy computation, change notification, or make it read-only/computed without changing the calling code — whereas swapping a public field for a property is a binary-breaking API change. Properties preserve encapsulation while reading like field access.

---
← [Previous: Collections](../07_collections/README.md) | [Next: Error Handling →](../09_errors/README.md)

# Object-Oriented Programming

Java supports single class inheritance (`extends`) plus multiple interface implementation (`implements`), abstract classes, and — since Java 16 — `record`, a concise way to declare an immutable data class that gets constructor, accessors, `equals`, `hashCode`, and `toString` generated automatically.

## Example

```java
interface Speaker {
	String speak();
}

abstract class Animal implements Speaker {
	protected final String name;
	Animal(String name) { this.name = name; }
}

class Dog extends Animal {
	Dog(String name) { super(name); }
	public String speak() { return name + " says Woof"; }
}

// a record: equals/hashCode/toString/accessors all generated
record Point(int x, int y) {}

Point p1 = new Point(3, 4);
Point p2 = new Point(3, 4);
p1.equals(p2);   // true — records compare by field value, not identity
p1.x();           // 3 — accessor named after the field, no "get" prefix
```

See [`Example.java`](./Example.java) for the full runnable file.

## Common mistakes

1. **Writing a full class with manual `equals`/`hashCode`/constructor/getters for what's really just an immutable data holder.** A `record` generates all of that from the field list — far less boilerplate for the common "bag of immutable fields" case.
2. **Forgetting a regular class's default `equals()` compares by reference identity**, not field values — unless you override `equals`/`hashCode` yourself, two instances with identical field values are `!equals()`. Records don't have this problem.
3. **Overriding `equals()` without also overriding `hashCode()`** (or vice versa) — violates the contract that equal objects must have equal hash codes, breaking `HashMap`/`HashSet` behavior in subtle ways.
4. **Using implementation inheritance (`extends`) where composition or an interface would be more flexible** — Java allows only single class inheritance, so committing to `extends` for one relationship forecloses extending anything else; prefer interfaces for "can do X" and composition for "has a Y."

## Exercise

Define a `record Rectangle(double width, double height)` with a method `area()` returning `width * height`.

Try it yourself first, then check [`solutions/Exercise1.java`](./solutions/Exercise1.java).

## Interview questions

1. **What does a `record` generate automatically that a regular class doesn't get for free?** — A canonical constructor, accessor methods named after each field (no `get` prefix), and correctly implemented `equals()`, `hashCode()`, and `toString()` based on all the fields — a regular class must implement all of that by hand (or via an IDE/Lombok).
2. **Why must `equals()` and `hashCode()` be overridden together?** — The general contract requires that if `a.equals(b)` is `true`, then `a.hashCode() == b.hashCode()` must also be `true`; breaking this causes objects to "disappear" from `HashMap`/`HashSet` lookups even when logically present, since those structures bucket by hash code first.

---
← [Previous: Collections](../07_collections/README.md) | [Next: Error Handling →](../09_errors/README.md)

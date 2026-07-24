# Object-Oriented Programming

JavaScript's `class` syntax is sugar over prototype-based inheritance — every object still has a prototype chain under the hood. Classes support single inheritance (`extends`), `super`, getters/setters, and (since ES2022) private fields (`#field`).

## Example

```javascript
class Animal {
  #name;
  constructor(name) {
    this.#name = name;
  }
  get name() {
    return this.#name;
  }
  speak() {
    throw new Error("not implemented");
  }
}

class Dog extends Animal {
  speak() {
    return `${this.name} says Woof`;
  }
}

class Cat extends Animal {
  speak() {
    return `${this.name} says Meow`;
  }
}

const animals = [new Dog("Rex"), new Cat("Tom")];
animals.map((a) => a.speak());   // polymorphism
```

See [`example.js`](./example.js) for the full runnable file.

## Common mistakes

1. **Forgetting `super(...)` in a subclass constructor before using `this`.** JavaScript throws a `ReferenceError` if you reference `this` in a derived class constructor before calling `super()` — this is enforced, not just a style issue.
2. **Losing `this` when passing a method as a callback.** `setTimeout(obj.method, 100)` calls `method` with `this` as `undefined` (in strict/class code) because it's detached from `obj`. Bind it (`obj.method.bind(obj)`) or use an arrow function wrapper.
3. **Mutating a class field that should be private via direct property access**, because it wasn't actually declared with `#`. A regular `this.name` field is still publicly accessible/mutable from outside the class; use `#name` for real encapsulation.
4. **Comparing two instances with `==`/`===` expecting value equality.** Like Python, JS object equality is by reference unless you write your own comparison method — two objects with identical fields are `!==` unless they're the same reference.

## Exercise

Write a `Rectangle` class with `width`/`height` (private fields), a `.area()` method, and an `.equals(other)` method comparing by `(width, height)`.

Try it yourself first, then check [`solutions/exercise_1.js`](./solutions/exercise_1.js).

## Interview questions

1. **Is JavaScript's `class` real classical inheritance, or something else?** — Syntactic sugar over prototype-based inheritance; under the hood, method lookup still walks the prototype chain, not a class hierarchy in the classical (e.g. Java/C++) sense.
2. **Why does referencing `this` before `super()` in a derived constructor throw?** — The base class is responsible for initializing the object; JavaScript enforces that `super()` runs first so `this` is fully set up before the subclass touches it.
3. **How do you get true private state on a class instance?** — `#fieldName` private fields (ES2022+); a `_fieldName` naming convention is just a convention and remains fully accessible from outside.

---
← [Previous: Collections](../07_collections/README.md) | [Next: Error Handling →](../09_errors/README.md)

# Object-Oriented Programming

Python classes support single and multiple inheritance, "dunder" methods for operator overloading, properties for computed attributes, and duck typing — Python rarely checks a type explicitly, it checks whether the object supports the operation used on it.

## Example

```python
class Animal:
    def __init__(self, name):
        self.name = name

    def speak(self):
        raise NotImplementedError

    def __repr__(self):
        return f"{type(self).__name__}({self.name!r})"


class Dog(Animal):
    def speak(self):
        return f"{self.name} says Woof"


class Cat(Animal):
    def speak(self):
        return f"{self.name} says Meow"


animals = [Dog("Rex"), Cat("Tom")]
[a.speak() for a in animals]   # polymorphism: same call, different behavior
```

See [`example.py`](./example.py) for the full runnable file.

## Common mistakes

1. **Mutable class-level attributes shared across instances.** `class Dog: tricks = []` — every instance shares the *same* list unless it's set in `__init__` as `self.tricks = []`. Mutating it on one instance affects all instances.
2. **Forgetting `super().__init__()` in a subclass** that overrides `__init__`, silently skipping the parent's setup.
3. **Overusing inheritance where composition is a better fit** — deep inheritance hierarchies get fragile; prefer "has-a" (composition) over "is-a" (inheritance) unless the subtype genuinely needs to be substitutable for the parent everywhere (Liskov substitution).
4. **Comparing instances with `==` without defining `__eq__`** — by default, `==` falls back to identity comparison (`is`), so two "equal-looking" instances compare unequal unless you implement `__eq__` (and `__hash__` if you need them in a set/dict).

## Exercise

Write a `Rectangle` class with `width` and `height`, a `.area()` method, and an `__eq__` that compares two rectangles by `(width, height)`.

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

## Interview questions

1. **What is duck typing, and how does it relate to Python's approach to polymorphism?** — "If it walks like a duck and quacks like a duck, it's a duck": Python doesn't require a common base class to call `.speak()` on different objects — it just calls the method and lets it fail at runtime if unsupported, rather than checking types upfront.
2. **What's the difference between an instance attribute and a class attribute?** — Class attributes are shared across all instances (defined directly in the class body); instance attributes are per-object (usually set via `self.x = ...` in `__init__`).
3. **What does `super()` do?** — Returns a proxy that delegates method calls to the next class in the MRO (method resolution order), most commonly used to call a parent class's `__init__` or overridden method.

---
← [Previous: Collections](../07_collections/README.md) | [Next: Error Handling →](../09_errors/README.md)

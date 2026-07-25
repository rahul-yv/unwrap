# Object-Oriented Programming

C++ is a full class-based OOP language: `class` with `public`/`private`/`protected` access, constructors and destructors, inheritance, and **virtual functions** for runtime polymorphism (dispatch through a vtable — exactly what `08_oop` in the C track built by hand). Modern C++ manages object lifetimes with smart pointers: `std::unique_ptr<T>` (sole ownership, freed automatically) and `std::shared_ptr<T>` (shared ownership via reference counting) replace raw `new`/`delete`.

## Example

```cpp
#include <memory>
#include <string>

class Animal {
public:
	Animal(std::string name) : name_(std::move(name)) {}
	virtual ~Animal() = default;              // virtual destructor: essential for base classes
	virtual std::string speak() const = 0;    // pure virtual: makes Animal abstract
protected:
	std::string name_;
};

class Dog : public Animal {
public:
	Dog(std::string name) : Animal(std::move(name)) {}
	std::string speak() const override {       // override keyword: compiler-checked
		return name_ + " says Woof";
	}
};

std::unique_ptr<Animal> pet = std::make_unique<Dog>("Rex");
std::string sound = pet->speak();              // "Rex says Woof" via virtual dispatch
```

See [`example.cpp`](./example.cpp) for the full runnable file.

## Common mistakes

1. **Forgetting a `virtual` destructor on a base class used polymorphically.** If you `delete` a derived object through a base-class pointer and the base destructor isn't `virtual`, only the base part is destroyed — the derived destructor never runs (undefined behavior, and a resource leak). Base classes with any virtual function should have a `virtual` (or defaulted-virtual) destructor.
2. **Using raw `new`/`delete` instead of smart pointers.** Manual memory management invites leaks and double-frees; `std::unique_ptr`/`std::make_unique` (sole ownership) and `std::shared_ptr` (shared) tie the object's lifetime to the smart pointer's scope via RAII — cleanup is automatic and exception-safe.
3. **Omitting `override` on an overriding method.** Without it, a typo in the signature (wrong parameter type, missing `const`) silently creates a *new* method instead of overriding the base one — the `override` keyword makes the compiler verify it actually overrides something.
4. **Object slicing: assigning a derived object to a base object by value.** `Animal a = dog;` copies only the `Animal` part, "slicing off" the derived data and losing virtual behavior — polymorphism requires a pointer or reference to the base (`Animal&`, `Animal*`, or a smart pointer), never a base value.

## Exercise

Define an abstract `class Shape` with a pure virtual `double area() const`, then a `class Rectangle : public Shape` with `width`/`height` members and an `area()` override. Store one in a `std::unique_ptr<Shape>` and call `area()` through it.

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).

## Interview questions

1. **Why must a base class destructor be `virtual` if the class is used polymorphically?** — So that deleting a derived object through a base-class pointer runs the derived destructor (not just the base one) — with a non-virtual destructor, only the base part is cleaned up, leaking whatever the derived class owned and formally causing undefined behavior.
2. **What is object slicing?** — Copying a derived object into a base-class *value* (`Base b = derived;`) truncates it to just the base portion, discarding the derived class's added members and its virtual-function overrides; polymorphism only works through base pointers/references, so you must avoid storing polymorphic objects by base value.

---
← [Previous: Collections](../07_collections/README.md) | [Next: Error Handling →](../09_errors/README.md)

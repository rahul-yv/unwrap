# Variables

C# is statically typed with `var` for local type inference (the type is still fixed at compile time — `var` just infers it from the initializer). The defining distinction is **value types vs reference types**: value types (`int`, `double`, `bool`, `struct`, `enum`) hold their data directly and are copied on assignment; reference types (`class`, `string`, arrays) hold a reference to data on the managed heap, and assignment copies the reference. `const` is a compile-time constant; `readonly` is a field that can only be set in a constructor.

## Example

```csharp
int age = 25;
var name = "Ada";          // inferred as string
age = age + 1;

const int MaxRetries = 3;   // compile-time constant

// value type: copied on assignment
int a = 5;
int b = a;
b = 10;                     // a is still 5

// reference type: the reference is copied, both point at the same object
int[] arr1 = { 1, 2, 3 };
int[] arr2 = arr1;
arr2[0] = 99;               // arr1[0] is now 99 too — same underlying array
```

See [`example.cs`](./example.cs) for the full runnable file.

## Common mistakes

1. **Assuming assignment copies the object for reference types.** `list2 = list1` copies the *reference*, not the list — mutating through one is visible through the other. To get an independent copy, construct a new object (`new List<int>(list1)`).
2. **Confusing `const` and `readonly`.** `const` must be a compile-time constant (a literal or constant expression) and is baked into callers; `readonly` can be assigned a runtime value in a constructor and is resolved at runtime — use `readonly` for values that depend on constructor arguments.
3. **Overusing `var` where it hides the type unhelpfully.** `var` is fine when the type is obvious from the right side (`var name = "Ada"`); it's less readable when the type comes from a non-obvious method call — then an explicit type documents intent.
4. **Forgetting that `string` is a reference type but behaves like a value** because it's immutable — assigning or "modifying" a string produces a new object, so you never observe shared-mutation surprises with strings the way you do with mutable reference types like `List<T>`.

## Exercise

Write a method `(int, int) Swap(int a, int b)` that returns the tuple `(b, a)`.

Try it yourself first, then check [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

## Interview questions

1. **What's the difference between a value type and a reference type in C#?** — A value type (`int`, `struct`, `enum`) stores its data inline and is copied wholesale on assignment or when passed by value; a reference type (`class`, array, `string`) stores a reference to an object on the managed heap, so assignment copies only the reference and both variables refer to the same object. This determines whether mutations are shared.
2. **What's the difference between `const` and `readonly`?** — `const` is a compile-time constant that must be initialized with a constant expression and is substituted directly into the code that uses it; `readonly` is a field that can be assigned once, either at declaration or in a constructor (so it can depend on runtime/constructor values), and is resolved at runtime.

---
← Previous: (start) | [Next: Data Types →](../02_datatypes/README.md)

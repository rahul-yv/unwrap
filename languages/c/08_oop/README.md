# Object-Oriented Programming

C has no classes, inheritance, or built-in polymorphism. `struct` groups data; "methods" are just regular functions that take a pointer to the struct as their first argument, by convention. Polymorphism is achievable by hand: a struct holding function pointers acts as a manual "vtable" — this is literally how C++ implements virtual dispatch under the hood, just without the compiler generating it for you.

## Example

```c
typedef struct {
	double width;
	double height;
} Rectangle;

double rectangle_area(const Rectangle *r) {   // "method": takes the struct pointer explicitly
	return r->width * r->height;
}

// manual polymorphism: a struct of function pointers acts as a vtable
typedef struct Shape {
	double (*area)(const struct Shape *self);
	double width, height;   // just for this example; a real design would use a union/void* per shape
} Shape;

double shape_area(const Shape *self) {
	return self->width * self->height;
}

Shape rect = {.area = shape_area, .width = 3, .height = 4};
double a = rect.area(&rect);   // 12 — dispatched through the function pointer
```

See [`example.c`](./example.c) for the full runnable file.

## Common mistakes

1. **Passing a struct by value to a "method" when it's meant to be mutated**, since pass-by-value copies the whole struct — mutating "methods" take a pointer (`Rectangle *r`) so changes are visible to the caller; read-only "methods" can take `const Rectangle *r` to also document that they won't modify it.
2. **Forgetting `->` (arrow) is needed to access a member through a pointer**, not `.` — `r.width` on a `Rectangle *r` is a compile error; it's `r->width` (or, more verbosely, `(*r).width`).
3. **Not initializing a struct's fields explicitly** and assuming safe/predictable defaults — like any local variable, an uninitialized struct's fields hold garbage unless zero-initialized (`Rectangle r = {0};`) or every field is set explicitly.
4. **Building a manual vtable but forgetting `self`/context has to be passed explicitly** into every function pointer call — unlike real OOP languages where `this`/`self` is implicit, C's manual polymorphism needs the struct pointer passed as an ordinary argument every time.

## Exercise

Define `typedef struct { double width; double height; } Rectangle;`, then write `double rectangle_area(const Rectangle *r)` and `int rectangle_equals(const Rectangle *a, const Rectangle *b)` comparing by `width`/`height`.

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c).

## Interview questions

1. **How would you implement polymorphism in plain C?** — By putting function pointers inside a struct (a manual "vtable") and having different "instances" populate those pointers with different concrete functions; calling `instance->method(instance, ...)` dispatches to whichever function was actually assigned, achieving the same effect as virtual dispatch without any language-level support for it.
2. **Why do "methods" in C take a pointer to the struct rather than the struct by value?** — Passing by value copies the entire struct, so any mutation inside the "method" would only affect the copy — a pointer lets the function operate on (and potentially modify) the caller's actual struct, and avoids the cost of copying a potentially large struct on every call.

---
← [Previous: Collections](../07_collections/README.md) | [Next: Error Handling →](../09_errors/README.md)

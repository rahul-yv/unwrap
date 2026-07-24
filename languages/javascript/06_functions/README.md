# Functions

Functions are first-class values. JavaScript has three ways to write one: function declarations (hoisted, have their own `this`), function expressions, and arrow functions (`=>`, no own `this`/`arguments` — they capture the enclosing scope's, which is exactly why they're preferred for callbacks). Parameters support defaults and rest (`...args`).

## Example

```javascript
function greet(name, greeting = "Hello") {
  return `${greeting}, ${name}!`;
}

const double = (x) => x * 2;

function total(...args) {
  return args.reduce((sum, n) => sum + n, 0);
}

function makeCounter() {
  let count = 0;
  return () => ++count;   // closure: remembers `count` across calls
}
```

See [`example.js`](./example.js) for the full runnable file.

## Common mistakes

1. **Using a regular `function` as an object method callback where `this` needs to refer to the object**, then losing `this` when the function is passed around detached from the object (e.g. as an event handler). Arrow functions don't have their own `this`, so a regular method calling `setTimeout(function() {...})` loses `this`, but `setTimeout(() => {...})` keeps the enclosing `this`.
2. **Relying on function hoisting for function expressions/arrow functions.** Only function *declarations* (`function foo() {}`) are hoisted with their full body; `const foo = () => {}` is hoisted as an uninitialized binding (temporal dead zone) — calling it before the line runs throws.
3. **Mutating a parameter that was passed a reference type**, unexpectedly changing the caller's data — if the function isn't supposed to mutate its input, copy it first (`[...arr]`, `{...obj}`).
4. **Forgetting a function with no explicit `return` returns `undefined`**, then being surprised by `undefined` downstream.

## Exercise

Write `makeCounter()` returning a zero-argument function; each call returns an incrementing count starting at 1, using a closure.

Try it yourself first, then check [`solutions/exercise_1.js`](./solutions/exercise_1.js).

## Interview questions

1. **Why do arrow functions not have their own `this`?** — They capture `this` lexically from the enclosing scope at definition time, which is why they're preferred for callbacks that need to preserve the surrounding object's `this`.
2. **What is a closure, and what does `makeCounter` demonstrate about it?** — A function that retains access to variables from its enclosing scope even after that scope has returned; each call to `makeCounter()` creates an independent `count` variable captured by its own returned function.
3. **What's the difference between a function declaration and a function expression regarding hoisting?** — Declarations are hoisted with their full body and callable before their textual position; expressions (including arrow functions assigned to `const`/`let`) are only hoisted as an uninitialized binding, so calling them before the assignment throws a `ReferenceError`.

---
← [Previous: Loops](../05_loops/README.md) | Next: Collections (coming soon)

# Modules and Packages

A module is just a `.py` file; importing it runs the file once and caches the result in `sys.modules`. A package is a directory containing an `__init__.py` (or, since Python 3.3, a namespace package without one) that groups related modules and can be imported as a unit.

## Example

```
mypackage/
  __init__.py
  helpers.py
```

```python
# mypackage/helpers.py
def greet(name):
    return f"Hello, {name}!"
```

```python
# using it
from mypackage.helpers import greet
greet("Ada")   # "Hello, Ada!"
```

See [`example.py`](./example.py) and [`mypackage/`](./mypackage/) for the full runnable files.

## Common mistakes

1. **Wildcard imports (`from module import *`)** — pollutes the namespace, hides where a name actually came from, and can silently shadow builtins. Import specific names or the module itself.
2. **Circular imports** — module A imports module B, which imports module A — causes an `ImportError` at import time in many arrangements. Usually fixed by restructuring (move the shared code to a third module) rather than by reordering imports.
3. **Confusing a script run directly (`python file.py`, where `__name__ == "__main__"`) with the same file imported as a module (`__name__` is the module's dotted name)** — code meant to run only when executed directly belongs under `if __name__ == "__main__":`.
4. **Relying on relative imports (`from . import helpers`) outside a real package context** — relative imports only work when the file is imported as part of a package, not when run directly as a script.

## Exercise

Given `mypackage/helpers.py` with a `greet(name)` function, write `example_usage()` in `solutions/exercise_1.py` that imports `greet` (name-specific import, not wildcard) and returns `greet("World")`.

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

## Interview questions

1. **What happens the second time you import a module that's already been imported?** — Python returns the cached module object from `sys.modules` instead of re-running the file; module-level code only executes once per process.
2. **Why is `from module import *` discouraged?** — It imports every public name into the current namespace, which can silently shadow existing names and makes it unclear where a given name was defined.

---
← [Previous: Files and I/O](../10_files/README.md) | [Next: Testing →](../12_testing/README.md)

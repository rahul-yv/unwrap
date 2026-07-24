# Modules and Packages

C has no built-in module system. The convention is a header file (`.h`, declarations only — function prototypes, type definitions, `extern` variable declarations) paired with a source file (`.c`, the actual implementation), `#include`d wherever the declarations are needed. Each `.c` file compiles independently into an object file; the linker combines them into one program. `static` at file scope (see `06_functions`) restricts a function/variable to that translation unit — C's closest equivalent to "private."

## Example

```c
// mypackage.h — declarations only
#ifndef MYPACKAGE_H
#define MYPACKAGE_H

char *greet(const char *name, char *buffer, int buffer_size);

#endif
```

```c
// mypackage.c — the implementation
#include "mypackage.h"
#include <stdio.h>

char *greet(const char *name, char *buffer, int buffer_size) {
	snprintf(buffer, (size_t)buffer_size, "Hello, %s!", name);
	return buffer;
}
```

```c
// using it — example.c
#include "mypackage.h"

char buffer[64];
greet("Ada", buffer, sizeof(buffer));
```

Compile all the source files together: `cc example.c mypackage.c -o example`. See [`example.c`](./example.c) and [`mypackage.h`](./mypackage.h)/[`mypackage.c`](./mypackage.c) for the full files.

## Common mistakes

1. **Forgetting an include guard (`#ifndef`/`#define`/`#endif`, or `#pragma once`) in a header file.** Without one, including the same header twice (directly or transitively through other headers) redefines everything in it, causing a "redefinition" compile error.
2. **Putting a function's actual implementation in the header** instead of just its prototype — if that header is included by more than one `.c` file, the linker sees the same function defined multiple times ("multiple definition" error), since each `.c` file compiles independently.
3. **Forgetting to compile and link every `.c` file the program needs.** `cc example.c -o example` alone, when `example.c` calls a function only defined in `mypackage.c`, fails at the link step ("undefined reference") — every source file providing needed definitions must be passed to the compiler/linker.
4. **Returning a pointer to a fixed-size local buffer from inside a function**, expecting the caller to use it safely — same dangling-pointer problem as `06_functions`; this is why `greet` above takes the caller's buffer as a parameter instead of allocating (or using a local array) internally.

## Exercise

Using `mypackage.h`/`mypackage.c`'s `greet`, write `char *example_usage(char *buffer, int buffer_size)` in `solutions/exercise_1.c` that calls `greet("World", buffer, buffer_size)` and returns the result.

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c) — compile with `cc solutions/exercise_1.c mypackage.c -o exercise_1`.

## Interview questions

1. **Why does a header file need an include guard?** — Headers are often included transitively (a header includes another header) — without a guard, the same declarations/definitions could be pulled into one translation unit multiple times, causing "redefinition" errors; the guard makes the second (and later) inclusion a no-op.
2. **What's the difference between a "declaration" and a "definition" in C, and why does it matter for headers?** — A declaration (`int foo(int);`) just describes a function's signature without providing a body; a definition (`int foo(int x) { return x + 1; }`) provides the actual implementation. Headers should contain declarations (safe to include in multiple files) — putting definitions there risks the linker seeing the same symbol defined more than once.

---
← [Previous: Files and I/O](../10_files/README.md) | [Next: Testing →](../12_testing/README.md)


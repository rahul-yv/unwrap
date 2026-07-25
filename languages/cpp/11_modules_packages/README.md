# Modules and Packages

C++ organizes code with **namespaces** (grouping names to avoid collisions — `std::` is the standard library's namespace) and, traditionally, the header/source split inherited from C: a `.hpp` header with declarations, a `.cpp` with definitions, `#include`d and compiled together. C++20 introduced true language-level **modules** (`export module`/`import`), which fix header include-order and macro-leakage problems — but toolchain support is still maturing, so header/source + namespaces remains the portable, universally-supported approach and is what this lesson uses.

## Example

```cpp
// mypackage.hpp — declarations, in a namespace
#ifndef MYPACKAGE_HPP
#define MYPACKAGE_HPP
#include <string>

namespace mypackage {
	std::string greet(const std::string& name);
}

#endif
```

```cpp
// mypackage.cpp — the definition
#include "mypackage.hpp"

namespace mypackage {
	std::string greet(const std::string& name) {
		return "Hello, " + name + "!";
	}
}
```

```cpp
// using it — example.cpp
#include "mypackage.hpp"

std::string result = mypackage::greet("Ada");   // qualified with the namespace
```

Compile all sources together: `c++ example.cpp mypackage.cpp -o example`. See [`example.cpp`](./example.cpp) and [`mypackage.hpp`](./mypackage.hpp)/[`mypackage.cpp`](./mypackage.cpp).

## Common mistakes

1. **`using namespace std;` (or any namespace) at file scope in a header.** It dumps every name from that namespace into every file that includes the header, defeating the collision-avoidance that namespaces exist for, and causing ambiguous-name errors in unexpected places. Qualify names (`std::string`) or use `using` narrowly inside a function.
2. **Forgetting an include guard** (`#ifndef`/`#define`/`#endif` or `#pragma once`) in a header — including it twice causes redefinition errors, exactly as in C.
3. **Putting function *definitions* (not just declarations) in a header** that's included by multiple `.cpp` files — the linker sees multiple definitions of the same symbol. (Exception: `inline` functions and templates, which are allowed in headers by design.)
4. **Expecting C++20 `import` to work everywhere.** Modules are standardized but not uniformly supported/configured across compilers and build systems yet — for portable code today, the header/source split is still the safe default.

## Exercise

Using `mypackage.hpp`/`mypackage.cpp`'s `mypackage::greet`, write `std::string example_usage()` in `solutions/exercise_1.cpp` returning `mypackage::greet("World")`.

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp) — compile with `c++ solutions/exercise_1.cpp mypackage.cpp -o exercise_1`.

## Interview questions

1. **What problem do namespaces solve, and why is `using namespace std;` in a header a bad idea?** — Namespaces prevent name collisions between different libraries/modules that happen to use the same identifiers. Putting `using namespace std;` in a header forces that unqualified access on every file that includes it (transitively), reintroducing exactly the collision risk namespaces exist to prevent — and it can silently change which overload a call resolves to.
2. **Why can't ordinary function definitions live in a header included by multiple source files?** — Each `.cpp` that includes the header would get its own copy of the definition, and the linker would see the same symbol defined multiple times (a violation of the One Definition Rule). Declarations belong in headers; definitions belong in one `.cpp` — except `inline` functions and templates, which are explicitly allowed in headers.

---
← [Previous: Files and I/O](../10_files/README.md) | [Next: Testing →](../12_testing/README.md)

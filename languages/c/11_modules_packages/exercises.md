# Exercises: Modules and Packages

1. Using `mypackage.h`/`mypackage.c`'s `greet`, write `char *example_usage(char *buffer, int buffer_size)` calling `greet("World", buffer, buffer_size)` and returning the result.
   - `example_usage(buffer, sizeof(buffer))` → `"Hello, World!"`

Compile with `cc solutions/exercise_1.c mypackage.c -o exercise_1`.

Check your answer against [`solutions/exercise_1.c`](./solutions/exercise_1.c).

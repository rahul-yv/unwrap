# Exercises: Collections

1. Write `int *make_range(int start, int end, int *out_len)` returning a heap-allocated array of every integer from `start` to `end` inclusive, setting `*out_len` to its length. The caller must `free` the result.
   - `make_range(1, 5, &len)` → `{1, 2, 3, 4, 5}`, `len == 5`

Check your answer against [`solutions/exercise_1.c`](./solutions/exercise_1.c).

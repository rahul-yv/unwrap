# Exercises: OOP

1. Define `typedef struct { double width; double height; } Rectangle;`.
2. Write `double rectangle_area(const Rectangle *r)` and `int rectangle_equals(const Rectangle *a, const Rectangle *b)` comparing by field values.
   - `rectangle_area(&(Rectangle){3, 4})` → `12`
   - Two rectangles with equal `width`/`height` → `rectangle_equals` returns `1`

Check your answer against [`solutions/exercise_1.c`](./solutions/exercise_1.c).

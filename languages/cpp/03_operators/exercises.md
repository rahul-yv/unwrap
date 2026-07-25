# Exercises: Operators

1. Define `struct Fraction { int num; int den; };` and overload `operator==` to compare by cross-multiplication (`a.num * b.den == b.num * a.den`).
   - `Fraction{1, 2} == Fraction{2, 4}` → `true`
   - `Fraction{1, 2} == Fraction{1, 3}` → `false`

Check your answer against [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).

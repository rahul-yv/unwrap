# Exercises: Operators

1. Write `getLength(value: string | number[]): number` using a `typeof` type guard to return `.length` for either case — no `as`.
   - `getLength("hello")` → `5`
   - `getLength([1, 2, 3])` → `3`

Check your answer against [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

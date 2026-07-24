# Exercises: Conditionals

1. Add a `Triangle` variant `{ kind: "triangle"; base: number; height: number }` to the `Shape` union, and update `area` to handle it (area = `0.5 * base * height`), keeping the `never` exhaustiveness check.
   - `area({ kind: "triangle", base: 4, height: 5 })` → `10`

Check your answer against [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

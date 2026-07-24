# Exercises: Error Handling

1. Write `describeError(err: unknown): string` returning `err.message` if `err instanceof Error`, otherwise `String(err)`.
   - `describeError(new Error("boom"))` → `"boom"`
   - `describeError("plain string")` → `"plain string"`
   - `describeError(42)` → `"42"`

Check your answer against [`solutions/exercise_1.ts`](./solutions/exercise_1.ts).

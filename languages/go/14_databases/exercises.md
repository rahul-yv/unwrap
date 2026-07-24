# Exercises: Databases

1. Write `getUserByName(db *sql.DB, name string) (int, string, error)` returning the user's `id, name` via a parameterized query, or `sql.ErrNoRows` if not found.

Check your answer against [`solutions/exercise_1.go`](./solutions/exercise_1.go).

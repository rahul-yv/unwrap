# Exercises: Databases

1. Write `int get_user_id_by_name(sqlite3* db, const std::string& name)` returning the `id` of the user with the given name via a parameterized query, or `-1` if not found.

Compile with `c++ solutions/exercise_1.cpp -o exercise_1 -lsqlite3`.

Check your answer against [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).

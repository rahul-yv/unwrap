# Exercises: Error Handling

1. Write a function `function safeParseInt(string $s): int|false` that parses `$s` as an integer, returning `false` if it isn't numeric (using `is_numeric()` to check rather than `try`/`catch`, since PHP's int casting doesn't throw).

Check your answer against [`solutions/exercise_1.php`](./solutions/exercise_1.php).

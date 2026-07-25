# Exercises: Error Handling

1. Write a method `def safe_parse_int(s)` that parses `s` as an integer, returning `nil` if it isn't a valid integer string (rescuing `ArgumentError` from `Integer(s)`, which raises rather than returning a sentinel the way `to_i` does).

Check your answer against [`solutions/exercise_1.rb`](./solutions/exercise_1.rb).

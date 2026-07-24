# Exercises: Networking and APIs

1. Write `fetchJSON(url string, target any) error` that GETs `url` with a 5-second timeout, checks the status is 200 (returning an error otherwise), and decodes the JSON body into `target`.

Check your answer against [`solutions/exercise_1.go`](./solutions/exercise_1.go).

# Exercises: Concurrency

1. Write an async function `fetchAllConcurrently(delays)` — given an array of millisecond delays, return an array of `` `waited ${ms}` `` strings, one per delay, with all waits happening concurrently (the function should take roughly as long as the longest delay, not the sum).

Check your answer against [`solutions/exercise_1.js`](./solutions/exercise_1.js).

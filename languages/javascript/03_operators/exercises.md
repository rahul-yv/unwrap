# Exercises: Operators

1. Write `getPort(config)` returning `config.port` if it's a number (including `0`), or `8080` if `config.port` is `null`/`undefined`. Use `??`.
   - `getPort({ port: 0 })` → `0`
   - `getPort({ port: 3000 })` → `3000`
   - `getPort({})` → `8080`

Check your answer against [`solutions/exercise_1.js`](./solutions/exercise_1.js).

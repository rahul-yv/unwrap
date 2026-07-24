# Exercises: Functions

1. Write `fn make_counter() -> impl FnMut() -> i32` returning a closure; each call returns an incrementing count starting at 1.

   ```rust
   let mut counter = make_counter();
   assert_eq!(counter(), 1);
   assert_eq!(counter(), 2);
   ```

Check your answer against [`solutions/exercise_1.rs`](./solutions/exercise_1.rs).

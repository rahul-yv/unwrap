# Exercises: Functions

1. Write `Func<int> MakeCounter()` returning a function; each call to the returned function returns an incrementing count starting at 1 (closure over a local variable).

   ```csharp
   var counter = MakeCounter();
   counter();  // 1
   counter();  // 2
   ```

Check your answer against [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

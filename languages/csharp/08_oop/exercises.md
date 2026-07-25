# Exercises: OOP

1. Define `interface IShape` with `double Area()`, then `record Rectangle(double Width, double Height) : IShape` implementing `Area()` as `Width * Height`.
   - `new Rectangle(3, 4).Area()` → `12`
   - `new Rectangle(3, 4) == new Rectangle(3, 4)` → `true` (record value equality)

Check your answer against [`solutions/exercise_1.cs`](./solutions/exercise_1.cs).

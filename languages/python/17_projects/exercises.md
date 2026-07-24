# Exercises: Mini Project

1. Write `top_words_excluding(path, n, stopwords)` — same as `top_words`, but words in `stopwords` (a set) are excluded before counting.
   - `top_words_excluding(path, 2, {"the"})` on text `"the cat the dog the bird"` → `[("dog", 1), ("bird", 1)]` or similar, excluding `"the"` entirely from consideration.

Check your answer against [`solutions/exercise_1.py`](./solutions/exercise_1.py).

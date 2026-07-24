# Exercises: Interview Prep

1. Write `group_anagrams(words)` grouping anagram words together. Aim for better than O(n² · k) (comparing every pair) — a canonical key per word (e.g. sorted letters) turns this into a single O(n · k log k) pass.
   - `group_anagrams(["eat", "tea", "tan", "ate", "nat", "bat"])` → groups equivalent to `[["eat", "tea", "ate"], ["tan", "nat"], ["bat"]]` (order of groups/within groups doesn't matter)

Check your answer against [`solutions/exercise_1.py`](./solutions/exercise_1.py).

# Folder structure

```
languages/
  <language>/
    01_variables/
      README.md
      example.<ext>
      exercises.md
      solutions/
        exercise_1.<ext>
      common_mistakes.md   # optional if it fits inline in README.md
    02_datatypes/
    ...
    18_interview/
      README.md            # question list + answers/approach notes
projects/
  <project-name>/
    README.md
    <language subfolders as needed>
  comparisons/
    <topic>.md              # side-by-side across languages
```

## Rules

- Topic folder names are fixed across every language: `01_variables` … `18_interview` (see `roadmap/languages.md`). Don't rename or reorder them per language.
- File extensions match the language (`example.py`, `example.go`, `example.rs`, …).
- Tests live next to the code they test, using that language's normal convention (e.g. `test_example.py`, `example_test.go`, `Example.test.js`).
- If a topic doesn't apply cleanly to a language (e.g. manual memory management topics in a garbage-collected language), don't force it — write a short README explaining why, instead of inventing filler content.
- Exception for languages that require a file's name to match a type defined inside it (Java, and similarly C#/Kotlin public classes): use `Example.java`/`Exercise1.java` (capitalized to match the class name) instead of the usual lowercase `example.<ext>` — this is a compiler requirement, not a style choice.

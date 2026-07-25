# Task Tracker — Kotlin

See [../README.md](../README.md) for the shared design.

`TaskTracker` wraps a JSON file — hand-rolled serialization/parsing via a fixed-shape regex, since Kotlin has no JSON in stdlib and this stays a single dependency-free file (matching the `kotlinc` single-file pattern used elsewhere in this repo). Uses a `data class Task` and throws `TaskNotFoundException` for an unknown id.

Run: `kotlinc task_tracker.kt -include-runtime -d task_tracker.jar && java -jar task_tracker.jar`

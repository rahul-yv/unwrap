# Mini Project: Task Tracker

A small persistent task list, implemented independently in a handful of languages to show the same design combining several topics at once: collections (an in-memory list of tasks), OOP (a `Task` type), files/IO (JSON persistence to disk), and error handling (invalid IDs, missing files).

This is a step up from each language track's own `17_projects` (a self-contained word frequency counter): here the same design is implemented once per language, so you can compare how idiomatic OOP, collection handling, and file I/O for one non-trivial program differ across languages side by side.

## Design

A `Task` has:
- `id` — a positive integer, assigned sequentially
- `description` — a non-empty string
- `done` — a boolean, `false` when created

Operations:
- `addTask(description) -> Task` — creates a task with the next sequential id, appends it to the list, persists, returns the created task.
- `listTasks() -> [Task]` — returns all tasks, in the order they were created.
- `completeTask(id)` — marks the task with that id as done; raises/throws/returns an error if no task has that id.
- `removeTask(id)` — removes the task with that id; raises/throws/returns an error if no task has that id.

Persistence: tasks are stored as JSON in a file (one array of task objects), loaded on startup and rewritten after every mutating operation. Each language's implementation is a library of these four operations (not a CLI parser) plus a self-check `main`/entry point that exercises all four operations with assertions and prints `ok` — matching the repo's usual "runnable, self-verifying example" convention, so it plugs into the same CI pattern as every topic lesson.

## Languages implemented

- [Python](./python/)
- [Go](./go/)
- [TypeScript](./typescript/)

## Topics this combines

Per language, roughly: `06_functions`, `07_collections`, `08_oop`, `09_errors`, `10_files`, and (for the JSON encoding/decoding) whatever each language's track used for structured data — see each language's `17_projects` for the equivalent single-topic-lighter version.

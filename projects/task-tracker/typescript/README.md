# Task Tracker — TypeScript

See [../README.md](../README.md) for the shared design.

`TaskTracker` wraps a JSON file: `addTask`, `listTasks`, `completeTask`, `removeTask`. Throws `TaskNotFoundError` (extends `Error`) for an unknown id.

Run: `npm install && npx tsx task_tracker.ts`

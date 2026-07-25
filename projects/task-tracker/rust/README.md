# Task Tracker — Rust

See [../README.md](../README.md) for the shared design.

`TaskTracker` wraps a JSON file (via `serde`/`serde_json`): `add_task`, `list_tasks`, `complete_task`, `remove_task`. The latter two return `Result<(), TaskNotFoundError>`.

Run: `cargo run`

# Task Tracker — Go

See [../README.md](../README.md) for the shared design.

`TaskTracker` wraps a JSON file: `AddTask`, `ListTasks`, `CompleteTask`, `RemoveTask`. Errors are returned as ordinary `error` values (Go's idiom), not exceptions.

Run: `go run .`

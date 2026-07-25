# Task Tracker — Python

See [../README.md](../README.md) for the shared design.

`TaskTracker` wraps a JSON file: `add_task`, `list_tasks`, `complete_task`, `remove_task`. Uses `dataclasses` for `Task`, raises `TaskNotFoundError` (a plain `Exception` subclass) for an unknown id.

Run: `python3 task_tracker.py`

# Files and I/O

Use `open()` as a context manager (`with open(...) as f:`) so the file is always closed, even if an exception occurs. Python distinguishes text mode (`"r"`, decodes bytes to `str` using an encoding) from binary mode (`"rb"`, raw `bytes`). The `pathlib` module is the modern, object-oriented way to work with filesystem paths.

## Example

```python
from pathlib import Path

path = Path("notes.txt")
path.write_text("line one\nline two\n")

with open(path) as f:
    lines = f.readlines()

for line in path.read_text().splitlines():
    print(line)

path.unlink()   # delete the file
```

See [`example.py`](./example.py) for the full runnable file.

## Common mistakes

1. **Opening a file without a context manager** (`f = open(path); ...; f.close()`) — if an exception happens between `open` and `close`, the file handle leaks. Always use `with open(...) as f:`.
2. **Forgetting to specify encoding on non-UTF-8 systems**, causing `UnicodeDecodeError` on data that isn't in the platform's default encoding. Pass `encoding="utf-8"` explicitly when you know the file's encoding.
3. **Reading an entire large file into memory with `.read()`** when the task only needs to process it line by line — iterate the file object directly (`for line in f:`) to stream it instead.
4. **Mixing `os.path` string manipulation with `pathlib.Path` objects** inconsistently in the same codebase — pick one; `pathlib` is generally preferred in modern code.

## Exercise

Write a function `count_lines(path)` that returns the number of lines in a text file at `path`, without loading the whole file into memory at once (iterate the file object).

Try it yourself first, then check [`solutions/exercise_1.py`](./solutions/exercise_1.py).

## Interview questions

1. **Why use `with open(...) as f:` instead of manually calling `.close()`?** — Guarantees the file is closed even if an exception is raised inside the block, via the context manager's `__exit__`.
2. **What's the difference between text mode and binary mode?** — Text mode decodes bytes to `str` using an encoding (and translates line endings); binary mode (`"rb"`/`"wb"`) reads/writes raw `bytes` with no decoding.

---
← [Previous: Error Handling](../09_errors/README.md) | [Next: Modules and Packages →](../11_modules_packages/README.md)

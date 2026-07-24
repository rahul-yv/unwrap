# Files and I/O

`<stdio.h>`'s `FILE *` and the `fopen`/`fclose`/`fread`/`fwrite`/`fgets`/`fprintf` family cover file I/O. Like heap memory, a `FILE *` is a resource you must explicitly release with `fclose` — there's no automatic cleanup when it goes out of scope.

## Example

```c
FILE *f = fopen("notes.txt", "w");
if (f == NULL) {
	// handle the error — fopen failing is common (permissions, missing directory, ...)
}
fprintf(f, "line one\n");
fprintf(f, "line two\n");
fclose(f);

FILE *in = fopen("notes.txt", "r");
char buffer[256];
while (fgets(buffer, sizeof(buffer), in) != NULL) {
	printf("%s", buffer);   // buffer includes the trailing newline, if present
}
fclose(in);

remove("notes.txt");
```

See [`example.c`](./example.c) for the full runnable file.

## Common mistakes

1. **Not checking `fopen`'s return value for `NULL`.** A missing file, wrong permissions, or a full disk (on write) all make `fopen` fail — dereferencing/using a `NULL` `FILE *` afterward crashes, at a point disconnected from the actual cause.
2. **Forgetting `fclose`**, leaking the file descriptor — like a `malloc` without a matching `free`, this is a resource leak that accumulates until the process exits (or the OS runs out of file descriptors).
3. **Passing the wrong size to `fgets`.** `fgets(buffer, sizeof(buffer), f)` relies on `sizeof(buffer)` being the actual buffer's size — passing a hardcoded number, or `sizeof` on a pointer instead of the actual array, can read past the buffer's real bounds.
4. **Assuming `fgets` strips the trailing newline.** It doesn't — the newline (if the line fit in the buffer and one was present in the file) is included in what `fgets` returns; strip it manually if it's unwanted (`buffer[strcspn(buffer, "\n")] = '\0';`).

## Exercise

Write `int count_lines(const char *path)` returning the number of lines in the file, or `-1` if the file can't be opened, using `fgets` in a loop.

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c).

## Interview questions

1. **Why must every successful `fopen` be paired with an `fclose`?** — `FILE *` wraps an OS file descriptor, a limited resource; without `fclose`, the descriptor (and any buffered but unwritten data) isn't released until the process exits, which is a real leak in a long-running program and can eventually exhaust the available descriptors.
2. **Does `fgets` include the newline character in what it reads?** — Yes, if the line (up to the buffer size) ends with one in the file — unlike some higher-level languages' line-reading functions that strip it automatically, C leaves the newline in the buffer for you to handle.

---
← [Previous: Error Handling](../09_errors/README.md) | [Next: Modules and Packages →](../11_modules_packages/README.md)


# Files and I/O

C++ file I/O uses stream classes from `<fstream>`: `std::ofstream` (output), `std::ifstream` (input), `std::fstream` (both). These are RAII objects — the file is opened by the constructor and **closed automatically by the destructor** when the stream goes out of scope, so there's no manual `fclose` to forget (a real improvement over C's `FILE*`). `std::getline` reads a line into a `std::string`, and the stream's boolean state signals success/EOF.

## Example

```cpp
#include <fstream>
#include <string>

{
	std::ofstream out("notes.txt");
	out << "line one\n" << "line two\n";
}   // out's destructor closes the file here — no explicit close needed

std::ifstream in("notes.txt");
if (!in) {
	// opening failed — always check
}
std::string line;
while (std::getline(in, line)) {   // reads until EOF; loop condition is the stream state
	// process line (getline strips the newline, unlike C's fgets)
}
```

See [`example.cpp`](./example.cpp) for the full runnable file.

## Common mistakes

1. **Not checking whether the stream opened successfully.** `std::ifstream in("missing.txt");` doesn't throw by default — it sets a failure state; test `if (!in)` (or `in.is_open()`) before reading, or reads silently produce nothing.
2. **Manually calling `.close()` and thinking it's required.** It's fine to call, but unnecessary — the stream's destructor closes the file automatically (RAII). The mistake is the opposite of C: here, *forgetting* to close is harmless because the destructor handles it; the anti-pattern is writing verbose manual open/close bookkeeping.
3. **Confusing `>>` (formatted extraction, stops at whitespace) with `std::getline` (reads a whole line).** `in >> word` reads one whitespace-delimited token; `std::getline(in, line)` reads through to the newline — mixing them (e.g. `>>` then `getline`) can leave a stray newline in the buffer.
4. **Assuming `std::getline` keeps the newline.** Unlike C's `fgets`, `std::getline` strips the delimiter (the `\n`) from the string it produces — so no manual trimming is needed (and manually trimming an already-stripped string can chop a real character).

## Exercise

Write `int count_lines(const std::string& path)` returning the number of lines in the file, or `-1` if it can't be opened, using `std::ifstream` and `std::getline`.

Try it yourself first, then check [`solutions/exercise_1.cpp`](./solutions/exercise_1.cpp).

## Interview questions

1. **How does C++ file I/O avoid the "forgot to close the file" bug that C's `FILE*` is prone to?** — `std::fstream`/`ifstream`/`ofstream` are RAII types: the destructor closes the file automatically when the stream object goes out of scope, so a file opened in a scope is always closed when that scope exits (even via an exception) — no manual `fclose` to forget.
2. **What's the difference between `stream >> value` and `std::getline(stream, line)`?** — `>>` performs formatted extraction: it skips leading whitespace and reads a single whitespace-delimited token (parsing into the target type); `std::getline` reads all characters up to (and discarding) the next newline into a `std::string`, so it captures whole lines including embedded spaces.

---
← [Previous: Error Handling](../09_errors/README.md) | [Next: Modules and Packages →](../11_modules_packages/README.md)

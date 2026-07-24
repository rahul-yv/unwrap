# Style guide

## Markdown

- One `#` H1 per file (the topic title). Use `##` for sections.
- Short paragraphs. Prefer lists over prose when enumerating.
- Fenced code blocks with a language tag, always: ` ```python `, ` ```go `, etc.
- Link previous/next topic at the bottom of every topic `README.md`:

  ```markdown
  ---
  ← [Previous: Variables](../01_variables/README.md) | [Next: Operators →](../03_operators/README.md)
  ```

## Code

- Idiomatic for the language — follow that language's dominant community style (PEP 8 for Python, `gofmt` for Go, `rustfmt` for Rust, Effective Java conventions, Airbnb/Standard-adjacent for JS, etc.).
- Runnable as-is. No pseudo-code presented as if it were real code.
- Comments explain *why*, not *what* — don't narrate obvious lines.
- No deprecated/legacy syntax unless the topic is explicitly about legacy patterns, and then label it clearly.

## Topic README shape

1. **Title + one-paragraph concept explanation** — plain, precise, no fluff.
2. **Example(s)** — one or more runnable files, referenced and briefly explained.
3. **Common mistakes** — 2-4 concrete pitfalls, each with the wrong version and the fix.
4. **Exercise(s)** — at least one, with a solution or hint available separately.
5. **Interview questions** — where relevant to the topic, 2-5 questions with short answers or pointers.
6. **Prev/next links.**

## Naming

- Files and folders: `snake_case`, lowercase.
- Topic numbering is zero-padded two digits (`01`, `02`, … `18`) so directory listings sort correctly.

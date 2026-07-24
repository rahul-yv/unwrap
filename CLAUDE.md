# Working in this repository

This file gives instructions for anyone (human or automated) contributing lessons to `unwrap`.

## Purpose

`unwrap` teaches programming languages and software engineering skills through consistent, self-contained lessons. Quality and consistency matter more than coverage speed.

## Before adding a lesson

1. Read `standards/style-guide.md`, `standards/folder-structure.md`, and `standards/writing-guidelines.md`.
2. Check `roadmap/progress.json` for what's already done and `roadmap/queue.md` for what's next.
3. Use `standards/example-template.md` as the starting skeleton for a new topic.
4. Match the topic numbering already used across languages (`01_variables` … `18_interview`) — don't invent new topic names per language.

## When writing a topic

- One topic = one self-contained folder: `README.md`, example source file(s), `exercises.md`, `solutions/`, tests where the language supports them, and a short "common mistakes" section.
- Code must be idiomatic for that language and actually run. Don't hand-wave syntax.
- Keep explanations plain and precise — no filler, no restating the obvious.
- Link to the previous and next topic at the bottom of each `README.md`.
- Don't duplicate an explanation that already exists elsewhere in the same language folder; link to it instead.

## Commits and PRs

- Conventional commits: `feat(python): add functions lesson`, `docs(java): add oop guide`, `test(go): add concurrency examples`, `chore(roadmap): mark topic complete`.
- One coherent topic (or a small group of closely related files) per commit/PR. Don't bundle unrelated languages or topics.
- Update `roadmap/progress.json` in the same PR as the content it tracks.
- No AI-tool attribution of any kind in commit messages, PR descriptions, or file content — author is `rahul-yv`.

## Quality bar

A topic is done when it can stand alone: someone with no other context can read it, run the example, do the exercise, and check their answer. If it can't do that yet, it isn't finished — mark it incomplete in the roadmap rather than merging it half-done.

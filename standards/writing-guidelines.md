# Writing guidelines

## Audience

Write for someone who can code in *some* language but is new to *this* one, or new to the concept entirely. Don't assume prior exposure to the specific language's ecosystem, but don't re-explain what a variable is in every single language's `01_variables` — assume general programming literacy, teach the language-specific part.

## Tone

Plain and direct. No marketing language ("powerful", "amazing", "simply"). No filler sentences that exist to pad length. State the concept, show it, move on.

## Explaining a concept

- Lead with what it is and why it exists, in one or two sentences.
- Show it before you describe every variation of it — code first, then the nuance.
- If a language does something unusual compared to other mainstream languages, say so explicitly (that's often the most useful sentence in the lesson).

## Common mistakes section

Real mistakes beginners actually make with that language, not generic "don't forget a semicolon" filler. Show the wrong code, what happens, and the fix.

## Exercises

- State the task unambiguously — input/output or expected behavior, not "practice functions" vagueness.
- Difficulty should roughly match the topic's position in the sequence (early topics = simple, later topics = compose multiple concepts).
- Solutions go in a `solutions/` subfolder or a clearly marked section below the exercise, never mixed inline with the exercise statement in a way that spoils it immediately.

## Interview questions

Only include where the topic genuinely comes up in interviews (e.g. this fits `08_oop`, `09_errors`, `15_concurrency` more than `01_variables`). Skip the section rather than inventing weak questions.

## Cross-language comparisons

Compare behavior, not opinions. State facts: "Python lists are dynamically resizable arrays; Go slices are a view over an underlying array with separate length/capacity" — not "Python is easier than Go."

# Error Handling

C has no exceptions. The universal convention is a return code: a function signals failure by returning a special value (often `-1`, `NULL`, or a nonzero status), and the caller is expected to check it — the compiler doesn't force this the way exception-based languages force a `catch`. Many standard library functions also set the global `errno` (from `<errno.h>`) to a specific error code on failure, decoded to a human-readable string with `strerror`.

## Example

```c
#include <errno.h>
#include <stdio.h>
#include <string.h>

FILE *f = fopen("missing.txt", "r");
if (f == NULL) {
	fprintf(stderr, "fopen failed: %s\n", strerror(errno));
}

int divide(int a, int b, int *result) {
	if (b == 0) {
		return -1;   // error: caller must check the return code
	}
	*result = a / b;
	return 0;   // success
}

int result;
if (divide(10, 0, &result) != 0) {
	// handle the error
}
```

See [`example.c`](./example.c) for the full runnable file.

## Common mistakes

1. **Not checking a function's return code at all**, assuming success — since there's no compiler enforcement, this compiles fine and fails silently (or crashes later, far from the actual cause) when the ignored error condition actually occurs.
2. **Checking `errno` without first confirming the call actually failed.** `errno` isn't reset to `0` automatically before each call — it only reflects the *last* error that occurred, so checking it after a call that actually succeeded can show a stale value from an earlier, unrelated failure.
3. **Using `-1` or `0` as an error sentinel for a function whose valid return range includes that value**, making success and failure indistinguishable — pick a sentinel outside the valid range, or use an output parameter for the real result and reserve the return value purely for a status code (as in the `divide` example above).
4. **Forgetting different failure modes need different error codes/messages.** Squashing every failure into a single generic "it failed" makes debugging much harder than a few distinct, specific codes would.

## Exercise

Write `int safe_divide(int a, int b, int *result)` returning `0` and setting `*result = a / b` on success, or returning `-1` (leaving `*result` untouched) if `b == 0`.

Try it yourself first, then check [`solutions/exercise_1.c`](./solutions/exercise_1.c).

## Interview questions

1. **Why is a return-code convention riskier than exceptions for signaling errors?** — Nothing forces the caller to check the return value — an ignored error return simply lets execution continue with bad/uninitialized data, whereas an uncaught exception in most other languages at least crashes loudly and immediately at the point something went wrong.
2. **Why must a return value used as an error sentinel be outside the function's normal valid range?** — If the sentinel value could also be produced by a genuinely successful call, the caller has no way to distinguish "this failed" from "this succeeded and happened to return that value" — which is why output parameters (for the real result) plus a dedicated status return are a common pattern for functions whose entire output range is valid.

---
← [Previous: OOP](../08_oop/README.md) | [Next: Files and I/O →](../10_files/README.md)

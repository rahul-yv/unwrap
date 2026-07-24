import assert from "node:assert";

function printLength(value: string | string[]): number {
  if (typeof value === "string") {
    return value.length; // narrowed to string here
  }
  return value.length; // narrowed to string[] here
}

interface MaybeUser {
  name: string;
}

function demo(): void {
  assert.strictEqual(printLength("hello"), 5);
  assert.strictEqual(printLength(["a", "b", "c"]), 3);

  const maybeUser: MaybeUser | undefined = { name: "Ada" };
  const name = maybeUser!.name; // non-null assertion
  assert.strictEqual(name, "Ada");

  const config = { mode: "dark" } satisfies { mode: "dark" | "light" };
  // config.mode retains the literal type "dark", not widened to "dark" | "light"
  assert.strictEqual(config.mode, "dark");

  const forced = "42" as unknown as number; // `as` performs no runtime conversion
  assert.strictEqual(typeof forced, "string"); // still a string at runtime, despite the type
}

demo();
console.log("ok");

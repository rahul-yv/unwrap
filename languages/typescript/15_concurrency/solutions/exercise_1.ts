import assert from "node:assert";

async function fetchAllConcurrently<T>(tasks: Array<() => Promise<T>>): Promise<T[]> {
  return Promise.all(tasks.map((task) => task()));
}

function wait(ms: number, value: string): Promise<string> {
  return new Promise((resolve) => setTimeout(() => resolve(value), ms));
}

async function main(): Promise<void> {
  const start = Date.now();
  const results = await fetchAllConcurrently([
    () => wait(40, "a"),
    () => wait(40, "b"),
    () => wait(40, "c"),
  ]);
  const duration = Date.now() - start;

  assert.deepStrictEqual(results, ["a", "b", "c"]);
  assert.ok(duration < 110); // well under 120 (3x sequential)

  console.log("ok");
}

main();

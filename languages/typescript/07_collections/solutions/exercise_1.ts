import assert from "node:assert";

function wordCounts(words: string[]): Map<string, number> {
  const counts = new Map<string, number>();
  for (const word of words) {
    counts.set(word, (counts.get(word) ?? 0) + 1);
  }
  return counts;
}

const result = wordCounts(["a", "b", "a"]);
assert.strictEqual(result.get("a"), 2);
assert.strictEqual(result.get("b"), 1);
console.log("ok");

const assert = require("assert");

function wordCounts(words) {
  return words.reduce((counts, word) => {
    counts.set(word, (counts.get(word) ?? 0) + 1);
    return counts;
  }, new Map());
}

const result = wordCounts(["a", "b", "a"]);
assert.strictEqual(result.get("a"), 2);
assert.strictEqual(result.get("b"), 1);
assert.strictEqual(result.size, 2);
console.log("ok");

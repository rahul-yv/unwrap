const assert = require("assert");
const fs = require("node:fs/promises");
const path = require("node:path");
const os = require("node:os");

function countWords(text) {
  const words = text.toLowerCase().match(/[a-z']+/g) || [];
  const counts = new Map();
  for (const word of words) {
    counts.set(word, (counts.get(word) ?? 0) + 1);
  }
  return counts;
}

async function topWords(filePath, n) {
  let content;
  try {
    content = await fs.readFile(filePath, "utf8");
  } catch (err) {
    if (err.code === "ENOENT") throw new Error(`no such file: ${filePath}`);
    throw err;
  }

  const counts = countWords(content);
  return [...counts.entries()].sort((a, b) => b[1] - a[1]).slice(0, n);
}

async function demo() {
  const counts = countWords("The cat sat. The cat ran!");
  assert.strictEqual(counts.get("the"), 2);
  assert.strictEqual(counts.get("cat"), 2);
  assert.strictEqual(counts.get("sat"), 1);

  const filePath = path.join(os.tmpdir(), `unwrap-story-${Date.now()}.txt`);
  await fs.writeFile(filePath, "dog dog cat bird dog cat", "utf8");

  const top = await topWords(filePath, 2);
  assert.deepStrictEqual(top, [
    ["dog", 3],
    ["cat", 2],
  ]);

  await fs.unlink(filePath);

  try {
    await topWords(path.join(os.tmpdir(), "missing.txt"), 2);
    assert.fail("expected an error");
  } catch (err) {
    assert.ok(err.message.includes("no such file"));
  }
}

module.exports = { countWords, topWords };

if (require.main === module) {
  demo().then(() => console.log("ok"));
}

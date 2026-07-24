const assert = require("assert");
const fs = require("node:fs/promises");
const path = require("node:path");
const os = require("node:os");

async function topWordsExcluding(filePath, n, stopwords) {
  const content = await fs.readFile(filePath, "utf8");
  const words = (content.toLowerCase().match(/[a-z']+/g) || []).filter(
    (w) => !stopwords.has(w)
  );

  const counts = new Map();
  for (const word of words) {
    counts.set(word, (counts.get(word) ?? 0) + 1);
  }

  return [...counts.entries()].sort((a, b) => b[1] - a[1]).slice(0, n);
}

async function main() {
  const filePath = path.join(os.tmpdir(), `unwrap-stop-${Date.now()}.txt`);
  await fs.writeFile(filePath, "the cat the dog the dog bird", "utf8");

  const result = await topWordsExcluding(filePath, 2, new Set(["the"]));
  assert.deepStrictEqual(result, [
    ["dog", 2],
    ["cat", 1],
  ]);

  await fs.unlink(filePath);
  console.log("ok");
}

main();

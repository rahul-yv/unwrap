import assert from "node:assert";
import fs from "node:fs/promises";
import os from "node:os";
import path from "node:path";

async function topWordsExcluding(
  filePath: string,
  n: number,
  stopwords: Set<string>
): Promise<Array<[string, number]>> {
  const content = await fs.readFile(filePath, "utf8");
  const words = (content.toLowerCase().match(/[a-z']+/g) ?? []).filter((w) => !stopwords.has(w));

  const counts = new Map<string, number>();
  for (const word of words) {
    counts.set(word, (counts.get(word) ?? 0) + 1);
  }

  return [...counts.entries()].sort((a, b) => b[1] - a[1]).slice(0, n);
}

async function main(): Promise<void> {
  const filePath = path.join(os.tmpdir(), `unwrap-ts-stop-${Date.now()}.txt`);
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

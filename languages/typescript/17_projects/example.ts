import assert from "node:assert";
import fs from "node:fs/promises";
import os from "node:os";
import path from "node:path";

function countWords(text: string): Map<string, number> {
  const words: string[] = text.toLowerCase().match(/[a-z']+/g) ?? [];
  const counts = new Map<string, number>();
  for (const word of words) {
    counts.set(word, (counts.get(word) ?? 0) + 1);
  }
  return counts;
}

async function topWords(filePath: string, n: number): Promise<Array<[string, number]>> {
  let content: string;
  try {
    content = await fs.readFile(filePath, "utf8");
  } catch (err) {
    if (err instanceof Error && "code" in err && (err as NodeJS.ErrnoException).code === "ENOENT") {
      throw new Error(`no such file: ${filePath}`);
    }
    throw err;
  }

  const counts = countWords(content);
  return [...counts.entries()].sort((a, b) => b[1] - a[1]).slice(0, n);
}

async function demo(): Promise<void> {
  const counts = countWords("The cat sat. The cat ran!");
  assert.strictEqual(counts.get("the"), 2);
  assert.strictEqual(counts.get("cat"), 2);

  const filePath = path.join(os.tmpdir(), `unwrap-ts-story-${Date.now()}.txt`);
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
    assert.ok(err instanceof Error && err.message.includes("no such file"));
  }
}

demo().then(() => console.log("ok"));

import assert from "node:assert";
import fs from "node:fs/promises";
import os from "node:os";
import path from "node:path";

async function countLines(filePath: string): Promise<number> {
  const content: string = await fs.readFile(filePath, "utf8");
  return content.split("\n").filter((line) => line.length > 0).length;
}

async function main(): Promise<void> {
  const filePath = path.join(os.tmpdir(), `unwrap-ts-count-${Date.now()}.txt`);
  await fs.writeFile(filePath, "a\nb\nc\n", "utf8");

  assert.strictEqual(await countLines(filePath), 3);

  await fs.unlink(filePath);
  console.log("ok");
}

main();

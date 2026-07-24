import assert from "node:assert";
import fs from "node:fs/promises";
import os from "node:os";
import path from "node:path";

async function readNotes(filePath: string): Promise<string[]> {
  const content: string = await fs.readFile(filePath, "utf8");
  return content.split("\n").filter((line) => line.length > 0);
}

async function readRaw(filePath: string): Promise<Buffer> {
  return fs.readFile(filePath);
}

async function demo(): Promise<void> {
  const filePath = path.join(os.tmpdir(), `unwrap-ts-notes-${Date.now()}.txt`);
  await fs.writeFile(filePath, "line one\nline two\n", "utf8");

  const lines = await readNotes(filePath);
  assert.deepStrictEqual(lines, ["line one", "line two"]);

  const raw = await readRaw(filePath);
  assert.ok(Buffer.isBuffer(raw));

  let threw = false;
  try {
    await fs.readFile(path.join(os.tmpdir(), "definitely-missing.txt"), "utf8");
  } catch (err: unknown) {
    threw = true;
    assert.ok(err instanceof Error);
    if (err instanceof Error && "code" in err) {
      assert.strictEqual((err as NodeJS.ErrnoException).code, "ENOENT");
    }
  }
  assert.strictEqual(threw, true);

  await fs.unlink(filePath);
}

demo().then(() => console.log("ok"));

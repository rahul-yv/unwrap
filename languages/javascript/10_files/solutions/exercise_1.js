const assert = require("assert");
const fs = require("node:fs/promises");
const path = require("node:path");
const os = require("node:os");

async function countLines(filePath) {
  const content = await fs.readFile(filePath, "utf8");
  return content.split("\n").filter((line) => line.length > 0).length;
}

async function main() {
  const filePath = path.join(os.tmpdir(), `unwrap-count-${Date.now()}.txt`);
  await fs.writeFile(filePath, "a\nb\nc\n", "utf8");

  assert.strictEqual(await countLines(filePath), 3);

  await fs.unlink(filePath);
  console.log("ok");
}

main();

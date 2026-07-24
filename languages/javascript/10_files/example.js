const assert = require("assert");
const fs = require("node:fs/promises");
const path = require("node:path");
const os = require("node:os");

async function demo() {
  const filePath = path.join(os.tmpdir(), `unwrap-notes-${Date.now()}.txt`);
  await fs.writeFile(filePath, "line one\nline two\n", "utf8");

  const content = await fs.readFile(filePath, "utf8");
  const lines = content.split("\n").filter(Boolean);
  assert.deepStrictEqual(lines, ["line one", "line two"]);

  const buffer = await fs.readFile(filePath); // no encoding -> Buffer
  assert.ok(Buffer.isBuffer(buffer));

  let threw = false;
  try {
    await fs.readFile(path.join(os.tmpdir(), "does-not-exist.txt"), "utf8");
  } catch (err) {
    threw = true;
    assert.strictEqual(err.code, "ENOENT");
  }
  assert.strictEqual(threw, true);

  await fs.unlink(filePath);
}

demo().then(() => console.log("ok"));

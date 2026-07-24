import assert from "node:assert";

async function fetchNumber(): Promise<number> {
  return 42;
}
async function fetchLabel(): Promise<string> {
  return "done";
}

function wait(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function demo(): Promise<void> {
  const [n, label] = await Promise.all([fetchNumber(), fetchLabel()]);
  assert.strictEqual(n, 42);
  assert.strictEqual(label, "done");

  const startSequential = Date.now();
  await wait(40);
  await wait(40);
  const sequentialDuration = Date.now() - startSequential;

  const startConcurrent = Date.now();
  await Promise.all([wait(40), wait(40)]);
  const concurrentDuration = Date.now() - startConcurrent;

  assert.ok(concurrentDuration < sequentialDuration);

  const settled = await Promise.allSettled([
    Promise.resolve(1),
    Promise.reject(new Error("boom")),
  ]);
  assert.strictEqual(settled[0].status, "fulfilled");
  assert.strictEqual(settled[1].status, "rejected");
}

demo().then(() => console.log("ok"));

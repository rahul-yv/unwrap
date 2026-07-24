const assert = require("assert");
const { Worker, isMainThread, parentPort, workerData } = require("node:worker_threads");

function fetchAfter(ms, value) {
  return new Promise((resolve) => setTimeout(() => resolve(value), ms));
}

async function sequential() {
  const a = await fetchAfter(50, "a");
  const b = await fetchAfter(50, "b");
  const c = await fetchAfter(50, "c");
  return [a, b, c];
}

async function concurrent() {
  return Promise.all([fetchAfter(50, "a"), fetchAfter(50, "b"), fetchAfter(50, "c")]);
}

function sumInWorker(numbers) {
  return new Promise((resolve, reject) => {
    const worker = new Worker(__filename, { workerData: numbers });
    worker.on("message", resolve);
    worker.on("error", reject);
  });
}

if (!isMainThread) {
  // this file re-runs inside the worker; workerData holds the numbers to sum
  const sum = workerData.reduce((acc, n) => acc + n, 0);
  parentPort.postMessage(sum);
} else {
  async function demo() {
    const startSeq = Date.now();
    const seqResult = await sequential();
    const seqDuration = Date.now() - startSeq;
    assert.deepStrictEqual(seqResult, ["a", "b", "c"]);

    const startConcurrent = Date.now();
    const concurrentResult = await concurrent();
    const concurrentDuration = Date.now() - startConcurrent;
    assert.deepStrictEqual(concurrentResult, ["a", "b", "c"]);

    // concurrent should be meaningfully faster than sequential (roughly 1/3)
    assert.ok(concurrentDuration < seqDuration);

    const settled = await Promise.allSettled([
      Promise.resolve(1),
      Promise.reject(new Error("boom")),
    ]);
    assert.strictEqual(settled[0].status, "fulfilled");
    assert.strictEqual(settled[1].status, "rejected");

    const workerSum = await sumInWorker([1, 2, 3, 4, 5]);
    assert.strictEqual(workerSum, 15);
  }

  demo().then(() => console.log("ok"));
}

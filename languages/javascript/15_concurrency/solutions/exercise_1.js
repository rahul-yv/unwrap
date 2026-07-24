const assert = require("assert");

function wait(ms) {
  return new Promise((resolve) => setTimeout(() => resolve(`waited ${ms}`), ms));
}

async function fetchAllConcurrently(delays) {
  return Promise.all(delays.map((ms) => wait(ms)));
}

async function main() {
  const start = Date.now();
  const results = await fetchAllConcurrently([50, 50, 50]);
  const duration = Date.now() - start;

  assert.deepStrictEqual(results, ["waited 50", "waited 50", "waited 50"]);
  assert.ok(duration < 140); // well under 150 (3x sequential), proving concurrency

  console.log("ok");
}

main();

const assert = require("assert");

function getPort(config) {
  return config.port ?? 8080;
}

assert.strictEqual(getPort({ port: 0 }), 0);
assert.strictEqual(getPort({ port: 3000 }), 3000);
assert.strictEqual(getPort({}), 8080);
console.log("ok");

const assert = require("assert");
const http = require("node:http");

async function fetchJson(url, options) {
  const response = await fetch(url, options);
  if (!response.ok) {
    throw new Error(`request to ${url} failed with status ${response.status}`);
  }
  return response.json();
}

function startServer(status, body) {
  const server = http.createServer((req, res) => {
    res.writeHead(status, { "Content-Type": "application/json" });
    res.end(JSON.stringify(body));
  });
  return new Promise((resolve) => server.listen(0, "127.0.0.1", () => resolve(server)));
}

async function main() {
  const okServer = await startServer(200, { ok: true });
  const okPort = okServer.address().port;
  assert.deepStrictEqual(await fetchJson(`http://127.0.0.1:${okPort}/`), { ok: true });
  okServer.close();

  const errorServer = await startServer(500, { error: "boom" });
  const errorPort = errorServer.address().port;
  try {
    await fetchJson(`http://127.0.0.1:${errorPort}/`);
    assert.fail("expected an error");
  } catch (err) {
    assert.ok(err.message.includes("500"));
  }
  errorServer.close();

  console.log("ok");
}

main();

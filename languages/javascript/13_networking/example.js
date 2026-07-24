const assert = require("assert");
const http = require("node:http");

function startServer() {
  const server = http.createServer((req, res) => {
    if (req.method === "POST" && req.url === "/api") {
      let body = "";
      req.on("data", (chunk) => (body += chunk));
      req.on("end", () => {
        const parsed = JSON.parse(body);
        res.writeHead(200, { "Content-Type": "application/json" });
        res.end(JSON.stringify({ echo: parsed }));
      });
      return;
    }
    res.writeHead(404);
    res.end();
  });
  return new Promise((resolve) => {
    server.listen(0, "127.0.0.1", () => resolve(server));
  });
}

async function demo() {
  const server = await startServer();
  const port = server.address().port;

  try {
    const response = await fetch(`http://127.0.0.1:${port}/api`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ name: "Ada" }),
      signal: AbortSignal.timeout(5000),
    });
    assert.strictEqual(response.ok, true);
    const body = await response.json();
    assert.deepStrictEqual(body, { echo: { name: "Ada" } });

    const missing = await fetch(`http://127.0.0.1:${port}/missing`);
    assert.strictEqual(missing.ok, false);
    assert.strictEqual(missing.status, 404);
  } finally {
    server.close();
  }
}

demo().then(() => console.log("ok"));

import assert from "node:assert";
import http from "node:http";

interface EchoResponse {
  echo: { name: string };
}

function startServer(): Promise<http.Server> {
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

async function postName(url: string, name: string): Promise<EchoResponse> {
  const response = await fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ name }),
    signal: AbortSignal.timeout(5000),
  });
  if (!response.ok) {
    throw new Error(`request failed: ${response.status}`);
  }
  return (await response.json()) as EchoResponse;
}

async function demo(): Promise<void> {
  const server = await startServer();
  const address = server.address();
  const port = typeof address === "object" && address !== null ? address.port : 0;

  try {
    const result = await postName(`http://127.0.0.1:${port}/api`, "Ada");
    assert.strictEqual(result.echo.name, "Ada");

    const missing = await fetch(`http://127.0.0.1:${port}/missing`);
    assert.strictEqual(missing.ok, false);
    assert.strictEqual(missing.status, 404);
  } finally {
    server.close();
  }
}

demo().then(() => console.log("ok"));

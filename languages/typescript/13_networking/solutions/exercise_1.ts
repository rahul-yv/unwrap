import assert from "node:assert";
import http from "node:http";

async function fetchJson<T>(url: string): Promise<T> {
  const response = await fetch(url);
  if (!response.ok) {
    throw new Error(`request to ${url} failed with status ${response.status}`);
  }
  return (await response.json()) as T;
}

function startServer(status: number, body: unknown): Promise<http.Server> {
  const server = http.createServer((_req, res) => {
    res.writeHead(status, { "Content-Type": "application/json" });
    res.end(JSON.stringify(body));
  });
  return new Promise((resolve) => server.listen(0, "127.0.0.1", () => resolve(server)));
}

interface OkBody {
  ok: boolean;
}

async function main(): Promise<void> {
  const okServer = await startServer(200, { ok: true });
  const okAddress = okServer.address();
  const okPort = typeof okAddress === "object" && okAddress !== null ? okAddress.port : 0;
  const result = await fetchJson<OkBody>(`http://127.0.0.1:${okPort}/`);
  assert.strictEqual(result.ok, true);
  okServer.close();

  const errorServer = await startServer(500, { error: "boom" });
  const errorAddress = errorServer.address();
  const errorPort = typeof errorAddress === "object" && errorAddress !== null ? errorAddress.port : 0;
  try {
    await fetchJson(`http://127.0.0.1:${errorPort}/`);
    assert.fail("expected an error");
  } catch (err) {
    assert.ok(err instanceof Error && err.message.includes("500"));
  }
  errorServer.close();

  console.log("ok");
}

main();

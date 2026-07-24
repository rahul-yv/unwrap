const assert = require("assert");
const { DatabaseSync } = require("node:sqlite");

function demo() {
  const db = new DatabaseSync(":memory:");
  db.exec("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)");

  const insert = db.prepare("INSERT INTO users (name) VALUES (?)");
  insert.run("Ada");

  const select = db.prepare("SELECT id, name FROM users WHERE name = ?");
  const row = select.get("Ada"); // returned row objects have a null prototype
  assert.strictEqual(row.id, 1);
  assert.strictEqual(row.name, "Ada");

  // parameterized query treats input as data, not SQL
  const malicious = "Ada' OR '1'='1";
  insert.run(malicious);
  const match = select.get(malicious);
  assert.strictEqual(match.name, malicious);

  const count = db.prepare("SELECT COUNT(*) AS n FROM users").get().n;
  assert.strictEqual(count, 2); // the injected OR '1'='1' did not select every row

  const missing = select.get("Nobody");
  assert.strictEqual(missing, undefined);

  db.close();
}

demo();
console.log("ok");

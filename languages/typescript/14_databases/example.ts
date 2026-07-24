import assert from "node:assert";
import { DatabaseSync } from "node:sqlite";

interface UserRow {
  id: number;
  name: string;
}

function demo(): void {
  const db = new DatabaseSync(":memory:");
  db.exec("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)");

  const insert = db.prepare("INSERT INTO users (name) VALUES (?)");
  insert.run("Ada");

  const select = db.prepare("SELECT id, name FROM users WHERE name = ?");
  const row = select.get("Ada") as UserRow | undefined;
  assert.ok(row !== undefined);
  assert.strictEqual(row.id, 1);
  assert.strictEqual(row.name, "Ada");

  const missing = select.get("Nobody") as UserRow | undefined;
  assert.strictEqual(missing, undefined);

  db.close();
}

demo();
console.log("ok");

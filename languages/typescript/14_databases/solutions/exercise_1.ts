import assert from "node:assert";
import { DatabaseSync } from "node:sqlite";

interface UserRow {
  id: number;
  name: string;
}

function getUserByName(db: DatabaseSync, name: string): UserRow | undefined {
  return db.prepare("SELECT id, name FROM users WHERE name = ?").get(name) as UserRow | undefined;
}

const db = new DatabaseSync(":memory:");
db.exec("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)");
db.prepare("INSERT INTO users (name) VALUES (?)").run("Ada");

const found = getUserByName(db, "Ada");
assert.ok(found !== undefined);
assert.strictEqual(found.name, "Ada");

assert.strictEqual(getUserByName(db, "Nobody"), undefined);

db.close();
console.log("ok");

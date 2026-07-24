const assert = require("assert");
const { DatabaseSync } = require("node:sqlite");

function getUserByName(db, name) {
  return db.prepare("SELECT id, name FROM users WHERE name = ?").get(name);
}

const db = new DatabaseSync(":memory:");
db.exec("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)");
db.prepare("INSERT INTO users (name) VALUES (?)").run("Ada");

const found = getUserByName(db, "Ada");
assert.strictEqual(found.id, 1);
assert.strictEqual(found.name, "Ada");

assert.strictEqual(getUserByName(db, "Nobody"), undefined);

db.close();
console.log("ok");

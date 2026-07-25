import "package:sqlite3/sqlite3.dart";

String? getUserName(Database db, int id) {
  final stmt = db.prepare("SELECT name FROM users WHERE id = ?");
  final result = stmt.select([id]);
  stmt.dispose();
  return result.isEmpty ? null : result.first["name"] as String;
}

void main() {
  final db = sqlite3.openInMemory();
  db.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)");
  final insert = db.prepare("INSERT INTO users (name) VALUES (?)");
  insert.execute(["Ada"]);
  insert.dispose();

  assert(getUserName(db, 1) == "Ada");
  assert(getUserName(db, 999) == null);

  db.dispose();
  print("ok");
}

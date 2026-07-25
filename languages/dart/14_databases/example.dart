import "package:sqlite3/sqlite3.dart";

void main() {
  final db = sqlite3.openInMemory();
  db.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)");

  final insert = db.prepare("INSERT INTO users (name) VALUES (?)");
  insert.execute(["Ada"]);
  insert.dispose();

  final select = db.prepare("SELECT name FROM users WHERE id = ?");
  final result = select.select([1]);
  assert(result.isNotEmpty);
  final name = result.first["name"];
  assert(name == "Ada");
  select.dispose();

  final missingSelect = db.prepare("SELECT name FROM users WHERE id = ?");
  final missingResult = missingSelect.select([999]);
  assert(missingResult.isEmpty);
  missingSelect.dispose();

  db.dispose();
  print("ok");
}

require "sqlite3"

db = SQLite3::Database.new(":memory:")
db.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)")

db.execute("INSERT INTO users (name) VALUES (?)", ["Ada"])

row = db.execute("SELECT name FROM users WHERE id = ?", [1]).first
raise "fail" unless row[0] == "Ada"

missing = db.execute("SELECT name FROM users WHERE id = ?", [999]).first
raise "fail" unless missing.nil?

db.close

puts "ok"

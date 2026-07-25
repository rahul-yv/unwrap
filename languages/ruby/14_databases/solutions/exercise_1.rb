require "sqlite3"

def get_user_name(db, id)
  row = db.execute("SELECT name FROM users WHERE id = ?", [id]).first
  row&.first
end

db = SQLite3::Database.new(":memory:")
db.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)")
db.execute("INSERT INTO users (name) VALUES (?)", ["Ada"])

raise "fail" unless get_user_name(db, 1) == "Ada"
raise "fail" unless get_user_name(db, 999).nil?

db.close
puts "ok"

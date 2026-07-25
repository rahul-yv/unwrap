import SQLite3

let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

func getUserName(_ db: OpaquePointer?, id: Int64) -> String? {
    var stmt: OpaquePointer?
    sqlite3_prepare_v2(db, "SELECT name FROM users WHERE id = ?", -1, &stmt, nil)
    defer { sqlite3_finalize(stmt) }
    sqlite3_bind_int64(stmt, 1, id)
    guard sqlite3_step(stmt) == SQLITE_ROW else { return nil }
    return String(cString: sqlite3_column_text(stmt, 0))
}

var db: OpaquePointer?
sqlite3_open(":memory:", &db)
sqlite3_exec(db, "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)", nil, nil, nil)

var insertStmt: OpaquePointer?
sqlite3_prepare_v2(db, "INSERT INTO users (name) VALUES (?)", -1, &insertStmt, nil)
sqlite3_bind_text(insertStmt, 1, "Ada", -1, SQLITE_TRANSIENT)
sqlite3_step(insertStmt)
sqlite3_finalize(insertStmt)

assert(getUserName(db, id: 1) == "Ada")
assert(getUserName(db, id: 999) == nil)

sqlite3_close(db)
print("ok")

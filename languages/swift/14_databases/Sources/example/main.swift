import CSQLite

let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

var db: OpaquePointer?
assert(sqlite3_open(":memory:", &db) == SQLITE_OK)
assert(sqlite3_exec(db, "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)", nil, nil, nil) == SQLITE_OK)

var insertStmt: OpaquePointer?
sqlite3_prepare_v2(db, "INSERT INTO users (name) VALUES (?)", -1, &insertStmt, nil)
sqlite3_bind_text(insertStmt, 1, "Ada", -1, SQLITE_TRANSIENT)
assert(sqlite3_step(insertStmt) == SQLITE_DONE)
sqlite3_finalize(insertStmt)

var selectStmt: OpaquePointer?
sqlite3_prepare_v2(db, "SELECT name FROM users WHERE id = ?", -1, &selectStmt, nil)
sqlite3_bind_int(selectStmt, 1, 1)
assert(sqlite3_step(selectStmt) == SQLITE_ROW)
let name = String(cString: sqlite3_column_text(selectStmt, 0))
assert(name == "Ada")
sqlite3_finalize(selectStmt)

var missingStmt: OpaquePointer?
sqlite3_prepare_v2(db, "SELECT name FROM users WHERE id = ?", -1, &missingStmt, nil)
sqlite3_bind_int(missingStmt, 1, 999)
assert(sqlite3_step(missingStmt) == SQLITE_DONE)
sqlite3_finalize(missingStmt)

sqlite3_close(db)

print("ok")

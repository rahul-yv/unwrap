#include <cassert>
#include <iostream>
#include <sqlite3.h>
#include <string>

int get_user_id_by_name(sqlite3* db, const std::string& name) {
    sqlite3_stmt* stmt = nullptr;
    if (sqlite3_prepare_v2(db, "SELECT id FROM users WHERE name = ?", -1, &stmt,
                           nullptr) != SQLITE_OK) {
        return -1;
    }
    sqlite3_bind_text(stmt, 1, name.c_str(), -1, SQLITE_TRANSIENT);

    int id = -1;
    if (sqlite3_step(stmt) == SQLITE_ROW) {
        id = sqlite3_column_int(stmt, 0);
    }
    sqlite3_finalize(stmt);
    return id;
}

int main() {
    sqlite3* db = nullptr;
    assert(sqlite3_open(":memory:", &db) == SQLITE_OK);
    sqlite3_exec(db, "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)", nullptr,
                 nullptr, nullptr);
    sqlite3_exec(db, "INSERT INTO users (name) VALUES ('Ada')", nullptr, nullptr, nullptr);

    assert(get_user_id_by_name(db, "Ada") == 1);
    assert(get_user_id_by_name(db, "Nobody") == -1);

    sqlite3_close(db);

    std::cout << "ok\n";
    return 0;
}

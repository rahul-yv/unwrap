#include <cassert>
#include <iostream>
#include <sqlite3.h>
#include <string>

// RAII guard: closes the database connection in its destructor
class Database {
public:
    Database() {
        assert(sqlite3_open(":memory:", &db_) == SQLITE_OK);
    }
    ~Database() {
        sqlite3_close(db_);
    }
    Database(const Database&) = delete;
    Database& operator=(const Database&) = delete;
    sqlite3* get() const { return db_; }

private:
    sqlite3* db_ = nullptr;
};

int main() {
    Database db;

    assert(sqlite3_exec(db.get(), "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)",
                        nullptr, nullptr, nullptr) == SQLITE_OK);

    sqlite3_stmt* insert = nullptr;
    assert(sqlite3_prepare_v2(db.get(), "INSERT INTO users (name) VALUES (?)", -1, &insert,
                              nullptr) == SQLITE_OK);
    sqlite3_bind_text(insert, 1, "Ada", -1, SQLITE_STATIC);
    assert(sqlite3_step(insert) == SQLITE_DONE);
    sqlite3_finalize(insert);

    sqlite3_stmt* select = nullptr;
    assert(sqlite3_prepare_v2(db.get(), "SELECT id, name FROM users WHERE name = ?", -1,
                              &select, nullptr) == SQLITE_OK);
    sqlite3_bind_text(select, 1, "Ada", -1, SQLITE_STATIC);
    assert(sqlite3_step(select) == SQLITE_ROW);
    int id = sqlite3_column_int(select, 0);
    std::string name = reinterpret_cast<const char*>(sqlite3_column_text(select, 1));
    assert(id == 1 && name == "Ada");
    sqlite3_finalize(select);

    // a malicious-looking string is treated as data, not SQL
    sqlite3_stmt* inject = nullptr;
    sqlite3_prepare_v2(db.get(), "INSERT INTO users (name) VALUES (?)", -1, &inject, nullptr);
    sqlite3_bind_text(inject, 1, "Ada' OR '1'='1", -1, SQLITE_STATIC);
    sqlite3_step(inject);
    sqlite3_finalize(inject);

    sqlite3_stmt* count = nullptr;
    sqlite3_prepare_v2(db.get(), "SELECT COUNT(*) FROM users", -1, &count, nullptr);
    sqlite3_step(count);
    assert(sqlite3_column_int(count, 0) == 2);
    sqlite3_finalize(count);

    std::cout << "ok\n";
    return 0;
}

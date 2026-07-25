#include <assert.h>
#include <sqlite3.h>
#include <stdio.h>
#include <string.h>

int main(void) {
    sqlite3 *db;
    assert(sqlite3_open(":memory:", &db) == SQLITE_OK);

    assert(sqlite3_exec(db, "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)",
                        NULL, NULL, NULL) == SQLITE_OK);

    // parameterized insert
    sqlite3_stmt *insert;
    assert(sqlite3_prepare_v2(db, "INSERT INTO users (name) VALUES (?)", -1, &insert,
                              NULL) == SQLITE_OK);
    sqlite3_bind_text(insert, 1, "Ada", -1, SQLITE_STATIC);
    assert(sqlite3_step(insert) == SQLITE_DONE);
    sqlite3_finalize(insert);

    // parameterized select
    sqlite3_stmt *select;
    assert(sqlite3_prepare_v2(db, "SELECT id, name FROM users WHERE name = ?", -1,
                              &select, NULL) == SQLITE_OK);
    sqlite3_bind_text(select, 1, "Ada", -1, SQLITE_STATIC);
    assert(sqlite3_step(select) == SQLITE_ROW);
    int id = sqlite3_column_int(select, 0);
    const unsigned char *name = sqlite3_column_text(select, 1);
    assert(id == 1);
    assert(strcmp((const char *)name, "Ada") == 0);
    sqlite3_finalize(select);

    // a malicious-looking string is treated as plain data, not SQL
    const char *malicious = "Ada' OR '1'='1";
    sqlite3_prepare_v2(db, "INSERT INTO users (name) VALUES (?)", -1, &insert, NULL);
    sqlite3_bind_text(insert, 1, malicious, -1, SQLITE_STATIC);
    sqlite3_step(insert);
    sqlite3_finalize(insert);

    sqlite3_stmt *count;
    sqlite3_prepare_v2(db, "SELECT COUNT(*) FROM users", -1, &count, NULL);
    assert(sqlite3_step(count) == SQLITE_ROW);
    assert(sqlite3_column_int(count, 0) == 2); // injection did not select every row
    sqlite3_finalize(count);

    sqlite3_close(db);

    printf("ok\n");
    return 0;
}

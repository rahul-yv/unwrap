import sqlite3


def get_user_by_name(conn, name):
    row = conn.execute(
        "SELECT id, name FROM users WHERE name = ?", (name,)
    ).fetchone()
    if row is None:
        return None
    return {"id": row[0], "name": row[1]}


if __name__ == "__main__":
    conn = sqlite3.connect(":memory:")
    conn.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)")
    conn.execute("INSERT INTO users (name) VALUES (?)", ("Ada",))
    conn.commit()

    assert get_user_by_name(conn, "Ada") == {"id": 1, "name": "Ada"}
    assert get_user_by_name(conn, "Nobody") is None

    conn.close()
    print("ok")

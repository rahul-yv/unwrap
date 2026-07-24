import sqlite3


def demo():
    conn = sqlite3.connect(":memory:")
    conn.execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)")
    conn.execute("INSERT INTO users (name) VALUES (?)", ("Ada",))
    conn.commit()

    row = conn.execute(
        "SELECT id, name FROM users WHERE name = ?", ("Ada",)
    ).fetchone()
    assert row == (1, "Ada")

    # parameterized query treats input as data, not SQL — safe even with
    # characters that would break naive string-formatted SQL
    malicious_name = "Ada' OR '1'='1"
    conn.execute("INSERT INTO users (name) VALUES (?)", (malicious_name,))
    conn.commit()
    match = conn.execute(
        "SELECT name FROM users WHERE name = ?", (malicious_name,)
    ).fetchone()
    assert match == (malicious_name,)
    total = conn.execute("SELECT COUNT(*) FROM users").fetchone()[0]
    assert total == 2  # the injected OR '1'='1' did not select every row

    conn.close()


if __name__ == "__main__":
    demo()
    print("ok")

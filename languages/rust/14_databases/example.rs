use rusqlite::{Connection, OptionalExtension};

fn main() -> rusqlite::Result<()> {
    let conn = Connection::open_in_memory()?;
    conn.execute(
        "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)",
        [],
    )?;

    conn.execute("INSERT INTO users (name) VALUES (?1)", ["Ada"])?;

    let name: String = conn.query_row("SELECT name FROM users WHERE id = 1", [], |row| {
        row.get(0)
    })?;
    assert_eq!(name, "Ada");

    // parameterized query treats input as data, not SQL
    let malicious = "Ada' OR '1'='1";
    conn.execute("INSERT INTO users (name) VALUES (?1)", [malicious])?;

    let count: i64 = conn.query_row("SELECT COUNT(*) FROM users", [], |row| row.get(0))?;
    assert_eq!(count, 2); // the injected OR '1'='1' did not select every row

    let missing: Option<String> = conn
        .query_row("SELECT name FROM users WHERE id = 999", [], |row| {
            row.get(0)
        })
        .optional()?;
    assert_eq!(missing, None);

    println!("ok");
    Ok(())
}

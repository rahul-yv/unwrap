use rusqlite::{Connection, OptionalExtension};

fn get_user_name(conn: &Connection, id: i64) -> rusqlite::Result<Option<String>> {
    conn.query_row("SELECT name FROM users WHERE id = ?1", [id], |row| {
        row.get(0)
    })
    .optional()
}

fn main() -> rusqlite::Result<()> {
    let conn = Connection::open_in_memory()?;
    conn.execute(
        "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)",
        [],
    )?;
    conn.execute("INSERT INTO users (name) VALUES (?1)", ["Ada"])?;

    assert_eq!(get_user_name(&conn, 1)?, Some("Ada".to_string()));
    assert_eq!(get_user_name(&conn, 999)?, None);

    println!("ok");
    Ok(())
}

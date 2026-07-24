package main

import (
	"database/sql"
	"fmt"

	_ "modernc.org/sqlite"
)

func must(condition bool, message string) {
	if !condition {
		panic(message)
	}
}

func main() {
	db, err := sql.Open("sqlite", ":memory:")
	must(err == nil, "sql.Open should succeed")
	defer db.Close()

	_, err = db.Exec("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)")
	must(err == nil, "CREATE TABLE should succeed")

	_, err = db.Exec("INSERT INTO users (name) VALUES (?)", "Ada")
	must(err == nil, "INSERT should succeed")

	var id int
	var name string
	err = db.QueryRow("SELECT id, name FROM users WHERE name = ?", "Ada").Scan(&id, &name)
	must(err == nil, "SELECT should find the inserted row")
	must(id == 1 && name == "Ada", "row values should match what was inserted")

	// parameterized query treats input as data, not SQL
	malicious := "Ada' OR '1'='1"
	_, err = db.Exec("INSERT INTO users (name) VALUES (?)", malicious)
	must(err == nil, "INSERT of the malicious-looking string should succeed as plain data")

	var count int
	err = db.QueryRow("SELECT COUNT(*) FROM users").Scan(&count)
	must(err == nil && count == 2, "the injected OR '1'='1' should not have selected every row")

	err = db.QueryRow("SELECT id FROM users WHERE name = ?", "Nobody").Scan(&id)
	must(err == sql.ErrNoRows, "querying a missing row should return sql.ErrNoRows")

	fmt.Println("ok")
}

package main

import (
	"database/sql"
	"fmt"

	_ "modernc.org/sqlite"
)

func getUserByName(db *sql.DB, name string) (int, string, error) {
	var id int
	var foundName string
	err := db.QueryRow("SELECT id, name FROM users WHERE name = ?", name).Scan(&id, &foundName)
	if err != nil {
		return 0, "", err
	}
	return id, foundName, nil
}

func main() {
	db, err := sql.Open("sqlite", ":memory:")
	if err != nil {
		panic(err)
	}
	defer db.Close()

	db.Exec("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT)")
	db.Exec("INSERT INTO users (name) VALUES (?)", "Ada")

	id, name, err := getUserByName(db, "Ada")
	if err != nil || id != 1 || name != "Ada" {
		panic("getUserByName(Ada) should find the row")
	}

	_, _, err = getUserByName(db, "Nobody")
	if err != sql.ErrNoRows {
		panic("getUserByName(Nobody) should return sql.ErrNoRows")
	}

	fmt.Println("ok")
}

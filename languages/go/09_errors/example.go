package main

import (
	"errors"
	"fmt"
)

func must(condition bool, message string) {
	if !condition {
		panic(message)
	}
}

var ErrNotFound = errors.New("not found")

func findUser(id int) (string, error) {
	if id != 1 {
		return "", fmt.Errorf("findUser(%d): %w", id, ErrNotFound)
	}
	return "Ada", nil
}

func recoverDemo() (result string) {
	defer func() {
		if r := recover(); r != nil {
			result = fmt.Sprintf("recovered: %v", r)
		}
	}()
	panic("something went very wrong")
}

func main() {
	name, err := findUser(1)
	must(err == nil && name == "Ada", "findUser(1) should succeed")

	_, err = findUser(2)
	must(err != nil, "findUser(2) should fail")
	must(errors.Is(err, ErrNotFound), "wrapped error should still match errors.Is")
	must(err != ErrNotFound, "wrapped error is a distinct value from the sentinel")

	result := recoverDemo()
	must(result == "recovered: something went very wrong", "recover should catch the panic")

	fmt.Println("ok")
}

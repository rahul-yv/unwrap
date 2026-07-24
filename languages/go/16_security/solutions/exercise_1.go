package main

import (
	"fmt"

	"golang.org/x/crypto/bcrypt"
)

func hashPassword(password string) (string, error) {
	hash, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return "", err
	}
	return string(hash), nil
}

func verifyPassword(password, hash string) bool {
	return bcrypt.CompareHashAndPassword([]byte(hash), []byte(password)) == nil
}

func main() {
	hash, err := hashPassword("hunter2")
	if err != nil {
		panic(err)
	}

	if !verifyPassword("hunter2", hash) {
		panic("verifyPassword should accept the correct password")
	}
	if verifyPassword("wrong", hash) {
		panic("verifyPassword should reject the wrong password")
	}

	fmt.Println("ok")
}

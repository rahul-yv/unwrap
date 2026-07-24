package main

import (
	"crypto/rand"
	"fmt"

	"golang.org/x/crypto/bcrypt"
)

func must(condition bool, message string) {
	if !condition {
		panic(message)
	}
}

func main() {
	hash, err := bcrypt.GenerateFromPassword([]byte("hunter2"), bcrypt.DefaultCost)
	must(err == nil, "GenerateFromPassword should succeed")

	err = bcrypt.CompareHashAndPassword(hash, []byte("hunter2"))
	must(err == nil, "correct password should match")

	err = bcrypt.CompareHashAndPassword(hash, []byte("wrong"))
	must(err != nil, "wrong password should not match")

	// same password hashed twice produces different hashes, because bcrypt
	// generates a fresh random salt each time
	otherHash, err := bcrypt.GenerateFromPassword([]byte("hunter2"), bcrypt.DefaultCost)
	must(err == nil, "second GenerateFromPassword should succeed")
	must(string(hash) != string(otherHash), "same password should hash differently each time")

	token := make([]byte, 16)
	_, err = rand.Read(token)
	must(err == nil, "crypto/rand.Read should succeed")
	must(len(token) == 16, "token should be 16 bytes")

	fmt.Println("ok")
}

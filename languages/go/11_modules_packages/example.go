package main

import (
	"fmt"

	"unwrap/go/11_modules_packages/mypackage"
)

func must(condition bool, message string) {
	if !condition {
		panic(message)
	}
}

func main() {
	must(mypackage.Greet("Ada") == "Hello, Ada!", "Greet should return a greeting")

	fmt.Println("ok")
}

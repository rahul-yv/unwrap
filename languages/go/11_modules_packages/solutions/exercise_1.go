package main

import (
	"fmt"

	"unwrap/go/11_modules_packages/mypackage"
)

func ExampleUsage() string {
	return mypackage.Greet("World")
}

func main() {
	if ExampleUsage() != "Hello, World!" {
		panic("ExampleUsage should greet World")
	}
	fmt.Println("ok")
}

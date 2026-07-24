package main

import "fmt"

func must(condition bool, message string) {
	if !condition {
		panic(message)
	}
}

func main() {
	age := 25
	var name string = "Ada"
	age = age + 1
	must(age == 26, "age should be 26")
	must(name == "Ada", "name should be Ada")

	var count int
	must(count == 0, "zero value of int should be 0")

	var label string
	must(label == "", "zero value of string should be empty")

	var ok bool
	must(ok == false, "zero value of bool should be false")

	a, b := 1, 2
	a, b = b, a
	must(a == 2 && b == 1, "swap should exchange values")

	fmt.Println("ok")
}

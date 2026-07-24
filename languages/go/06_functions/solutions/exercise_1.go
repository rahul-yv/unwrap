package main

import "fmt"

func makeCounter() func() int {
	count := 0
	return func() int {
		count++
		return count
	}
}

func main() {
	counter := makeCounter()
	if counter() != 1 || counter() != 2 || counter() != 3 {
		panic("counter should increment 1, 2, 3")
	}

	other := makeCounter()
	if other() != 1 {
		panic("a new counter should start fresh")
	}

	fmt.Println("ok")
}

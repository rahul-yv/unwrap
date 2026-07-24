package main

import "fmt"

func swap(a, b int) (int, int) {
	return b, a
}

func main() {
	x, y := swap(1, 2)
	if x != 2 || y != 1 {
		panic("swap failed")
	}
	fmt.Println("ok")
}

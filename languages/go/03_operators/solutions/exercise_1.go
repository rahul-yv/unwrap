package main

import "fmt"

func divide(a, b int) (int, bool) {
	if b == 0 {
		return 0, false
	}
	return a / b, true
}

func main() {
	if v, ok := divide(10, 2); v != 5 || !ok {
		panic("divide(10, 2) should be (5, true)")
	}
	if v, ok := divide(10, 0); v != 0 || ok {
		panic("divide(10, 0) should be (0, false)")
	}
	fmt.Println("ok")
}

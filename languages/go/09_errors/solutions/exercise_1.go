package main

import (
	"errors"
	"fmt"
)

func safeDivide(a, b float64) (float64, error) {
	if b == 0 {
		return 0, errors.New("division by zero")
	}
	return a / b, nil
}

func main() {
	result, err := safeDivide(10, 2)
	if err != nil || result != 5 {
		panic("safeDivide(10, 2) should return (5, nil)")
	}

	_, err = safeDivide(10, 0)
	if err == nil {
		panic("safeDivide(10, 0) should return an error")
	}

	fmt.Println("ok")
}

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

func divide(a, b float64) (float64, error) {
	if b == 0 {
		return 0, errors.New("division by zero")
	}
	return a / b, nil
}

func sum(nums ...int) int {
	total := 0
	for _, n := range nums {
		total += n
	}
	return total
}

func makeCounter() func() int {
	count := 0
	return func() int {
		count++
		return count
	}
}

func namedReturn(a, b int) (total int) {
	total = a + b
	return // bare return, sends back the current value of `total`
}

func main() {
	result, err := divide(10, 2)
	must(err == nil && result == 5, "divide(10, 2) should succeed with 5")

	_, err = divide(10, 0)
	must(err != nil, "divide(10, 0) should return an error")

	must(sum(1, 2, 3) == 6, "sum should add variadic args")

	numbers := []int{4, 5, 6}
	must(sum(numbers...) == 15, "sum should accept a spread slice")

	counter := makeCounter()
	must(counter() == 1 && counter() == 2 && counter() == 3, "counter should increment")

	other := makeCounter()
	must(other() == 1, "a new counter should have independent state")

	must(namedReturn(2, 3) == 5, "named return should send back total")

	fmt.Println("ok")
}

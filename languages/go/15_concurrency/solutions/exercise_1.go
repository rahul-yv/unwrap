package main

import "fmt"

func sumConcurrently(numbers []int) int {
	mid := len(numbers) / 2
	results := make(chan int, 2)

	sumHalf := func(nums []int) {
		total := 0
		for _, n := range nums {
			total += n
		}
		results <- total
	}

	go sumHalf(numbers[:mid])
	go sumHalf(numbers[mid:])

	return <-results + <-results
}

func main() {
	if sumConcurrently([]int{1, 2, 3, 4}) != 10 {
		panic("sumConcurrently should sum to 10")
	}
	if sumConcurrently([]int{}) != 0 {
		panic("sumConcurrently of empty slice should be 0")
	}
	fmt.Println("ok")
}

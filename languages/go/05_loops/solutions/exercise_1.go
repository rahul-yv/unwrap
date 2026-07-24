package main

import "fmt"

func sum(numbers []int) int {
	total := 0
	for _, n := range numbers {
		total += n
	}
	return total
}

func main() {
	if sum([]int{1, 2, 3}) != 6 {
		panic("sum([1,2,3]) should be 6")
	}
	if sum([]int{}) != 0 {
		panic("sum([]) should be 0")
	}
	fmt.Println("ok")
}

package main

import "fmt"

func wordCounts(words []string) map[string]int {
	counts := make(map[string]int)
	for _, w := range words {
		counts[w]++
	}
	return counts
}

func main() {
	counts := wordCounts([]string{"a", "b", "a"})
	if counts["a"] != 2 || counts["b"] != 1 {
		panic("wordCounts should count occurrences")
	}
	fmt.Println("ok")
}

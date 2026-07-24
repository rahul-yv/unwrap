package main

import (
	"fmt"
	"sort"
	"sync"
)

func must(condition bool, message string) {
	if !condition {
		panic(message)
	}
}

func main() {
	seen := []int{}
	for i := 0; i < 3; i++ {
		seen = append(seen, i)
	}
	must(len(seen) == 3 && seen[0] == 0 && seen[2] == 2, "classic for should collect 0,1,2")

	n := 0
	for n < 3 {
		n++
	}
	must(n == 3, "condition-only for should behave like while")

	count := 0
	for {
		count++
		if count == 3 {
			break
		}
	}
	must(count == 3, "infinite for should exit via break")

	indices := []int{}
	values := []string{}
	for i, v := range []string{"a", "b", "c"} {
		indices = append(indices, i)
		values = append(values, v)
	}
	must(len(indices) == 3 && values[1] == "b", "range should give index and value")

	rangeOverInt := []int{}
	for i := range 5 {
		rangeOverInt = append(rangeOverInt, i)
	}
	must(len(rangeOverInt) == 5 && rangeOverInt[4] == 4, "range over int should count 0..4")

	// Go 1.22+: each iteration gets its own loop variable, so goroutines
	// capturing it concurrently see the value from their own iteration
	var wg sync.WaitGroup
	var mu sync.Mutex
	captured := []int{}
	for _, v := range []int{10, 20, 30} {
		wg.Add(1)
		go func() {
			defer wg.Done()
			mu.Lock()
			captured = append(captured, v)
			mu.Unlock()
		}()
	}
	wg.Wait()
	sort.Ints(captured)
	must(len(captured) == 3 && captured[0] == 10 && captured[2] == 30, "each goroutine should capture its own iteration's value")

	fmt.Println("ok")
}

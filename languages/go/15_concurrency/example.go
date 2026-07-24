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
	results := make(chan int, 3)
	var wg sync.WaitGroup

	for i := 1; i <= 3; i++ {
		wg.Add(1)
		go func(n int) {
			defer wg.Done()
			results <- n * n
		}(i)
	}

	go func() {
		wg.Wait()
		close(results)
	}()

	collected := []int{}
	for r := range results {
		collected = append(collected, r)
	}
	sort.Ints(collected)
	must(len(collected) == 3 && collected[0] == 1 && collected[2] == 9, "should collect all squared values")

	// mutex protecting shared state, for cases where a channel isn't the natural fit
	var mu sync.Mutex
	counter := 0
	var wg2 sync.WaitGroup
	for i := 0; i < 100; i++ {
		wg2.Add(1)
		go func() {
			defer wg2.Done()
			mu.Lock()
			counter++
			mu.Unlock()
		}()
	}
	wg2.Wait()
	must(counter == 100, "mutex should prevent lost updates")

	// select waiting on whichever channel is ready first
	ch1 := make(chan string, 1)
	ch2 := make(chan string, 1)
	ch1 <- "from ch1"

	select {
	case msg := <-ch1:
		must(msg == "from ch1", "select should receive the ready channel's value")
	case msg := <-ch2:
		must(false, "ch2 was never sent to: "+msg)
	}

	fmt.Println("ok")
}

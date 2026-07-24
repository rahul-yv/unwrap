package main

import (
	"fmt"
	"reflect"
)

func must(condition bool, message string) {
	if !condition {
		panic(message)
	}
}

type Point struct {
	X, Y int
}

func main() {
	nums := []int{1, 2, 3}
	nums = append(nums, 4)
	must(len(nums) == 4, "append should grow the slice")

	m := map[string]int{"a": 1}
	m["b"] = 2
	value, ok := m["a"]
	must(value == 1 && ok, "map lookup should find existing key")

	var nilMap map[string]int
	readValue, readOk := nilMap["missing"]
	must(readValue == 0 && !readOk, "reading a nil map should return zero value, not panic")

	p := Point{X: 3, Y: 4}
	must(p.X == 3 && p.Y == 4, "struct fields should be accessible")

	p2 := Point{X: 3, Y: 4}
	must(p == p2, "structs with comparable fields support ==")

	must(reflect.DeepEqual([]int{1, 2, 3}, []int{1, 2, 3}), "DeepEqual should compare slice contents")

	// append sharing the underlying array: a slice with spare capacity
	base := make([]int, 3, 5) // length 3, capacity 5
	base[0], base[1], base[2] = 1, 2, 3
	shared := append(base, 4) // fits in existing capacity, no reallocation
	shared[0] = 99
	must(base[0] == 99, "append within capacity shares the underlying array")

	fmt.Println("ok")
}

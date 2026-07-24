package main

import "fmt"

func must(condition bool, message string) {
	if !condition {
		panic(message)
	}
}

func main() {
	q := 7 / 2
	r := 7 % 2
	must(q == 3, "7/2 should truncate to 3")
	must(r == 1, "7%2 should be 1")

	must(7.0/2 == 3.5, "float division should give a fractional result")

	m := map[string]int{"a": 1}
	value, ok := m["a"]
	must(value == 1 && ok, "existing key should return value and ok=true")

	missing, ok2 := m["z"]
	must(missing == 0 && !ok2, "missing key should return zero value and ok=false")

	label := "fail"
	if q > 0 {
		label = "pass"
	}
	must(label == "pass", "if/else replaces the ternary operator")

	fmt.Println("ok")
}

package main

import (
	"fmt"
	"unicode/utf8"
)

func must(condition bool, message string) {
	if !condition {
		panic(message)
	}
}

func main() {
	var n int = 10
	var small int8 = 127
	var pi float64 = 3.14159
	var name string = "Ada"
	var ok bool = true
	_ = n
	_ = pi
	_ = name
	_ = ok

	must(len("héllo") == 6, "byte length of héllo should be 6")
	must(utf8.RuneCountInString("héllo") == 5, "rune count of héllo should be 5")

	runeCount := 0
	for range "héllo" {
		runeCount++
	}
	must(runeCount == 5, "ranging over a string yields one iteration per rune")

	small++ // overflow: 127 + 1 wraps to -128 for int8, no error
	must(small == -128, "int8 overflow should wrap to -128")

	var a int32 = 5
	var b int64 = 10
	sum := int64(a) + b // explicit conversion required
	must(sum == 15, "explicit conversion should allow mixed arithmetic")

	fmt.Println("ok")
}

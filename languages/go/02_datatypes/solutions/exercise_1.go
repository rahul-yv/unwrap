package main

import (
	"fmt"
	"unicode/utf8"
)

func countRunes(s string) int {
	return utf8.RuneCountInString(s)
}

func main() {
	if countRunes("héllo") != 5 {
		panic("countRunes(héllo) should be 5")
	}
	if countRunes("hello") != 5 {
		panic("countRunes(hello) should be 5")
	}
	fmt.Println("ok")
}

package main

import "fmt"

func grade(score int) string {
	switch {
	case score >= 90:
		return "A"
	case score >= 80:
		return "B"
	case score >= 70:
		return "C"
	default:
		return "F"
	}
}

func main() {
	if grade(95) != "A" {
		panic("grade(95) should be A")
	}
	if grade(72) != "C" {
		panic("grade(72) should be C")
	}
	if grade(40) != "F" {
		panic("grade(40) should be F")
	}
	fmt.Println("ok")
}

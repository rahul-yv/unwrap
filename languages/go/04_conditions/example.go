package main

import "fmt"

func must(condition bool, message string) {
	if !condition {
		panic(message)
	}
}

func lookupGrade(score int) (string, bool) {
	if score < 0 || score > 100 {
		return "", false
	}
	if score >= 90 {
		return "A", true
	}
	return "B", true
}

func fallthroughDemo(n int) []int {
	hit := []int{}
	switch n {
	case 1:
		hit = append(hit, 1)
		fallthrough
	case 2:
		hit = append(hit, 2)
	case 3:
		hit = append(hit, 3)
	}
	return hit
}

func main() {
	score := 85

	result := ""
	if score >= 90 {
		result = "A"
	} else if score >= 80 {
		result = "B"
	} else {
		result = "C"
	}
	must(result == "B", "score 85 should be grade B")

	if grade, ok := lookupGrade(score); ok {
		must(grade == "B", "lookupGrade(85) should be B")
	} else {
		panic("lookupGrade(85) should succeed")
	}

	switchResult := ""
	switch {
	case score >= 90:
		switchResult = "A"
	case score >= 80:
		switchResult = "B"
	default:
		switchResult = "C"
	}
	must(switchResult == "B", "tagless switch should match if/else result")

	f1 := fallthroughDemo(1)
	must(len(f1) == 2 && f1[0] == 1 && f1[1] == 2, "fallthrough should include case 2")

	f3 := fallthroughDemo(3)
	must(len(f3) == 1 && f3[0] == 3, "case 3 without fallthrough should not continue")

	fmt.Println("ok")
}

package main

import (
	"fmt"
	"sort"
)

func must(condition bool, message string) {
	if !condition {
		panic(message)
	}
}

func twoSum(nums []int, target int) []int {
	seen := make(map[int]int)
	for i, n := range nums {
		if j, ok := seen[target-n]; ok {
			return []int{j, i}
		}
		seen[n] = i
	}
	return nil
}

func toLower(b byte) byte {
	if b >= 'A' && b <= 'Z' {
		return b + ('a' - 'A')
	}
	return b
}

func isAlnum(b byte) bool {
	return (b >= 'a' && b <= 'z') || (b >= 'A' && b <= 'Z') || (b >= '0' && b <= '9')
}

func isPalindrome(s string) bool {
	left, right := 0, len(s)-1
	for left < right {
		for left < right && !isAlnum(s[left]) {
			left++
		}
		for left < right && !isAlnum(s[right]) {
			right--
		}
		if toLower(s[left]) != toLower(s[right]) {
			return false
		}
		left++
		right--
	}
	return true
}

func mergeIntervals(intervals [][]int) [][]int {
	if len(intervals) == 0 {
		return [][]int{}
	}
	sorted := make([][]int, len(intervals))
	copy(sorted, intervals)
	sort.Slice(sorted, func(i, j int) bool { return sorted[i][0] < sorted[j][0] })

	merged := [][]int{sorted[0]}
	for _, interval := range sorted[1:] {
		last := merged[len(merged)-1]
		if interval[0] <= last[1] {
			if interval[1] > last[1] {
				last[1] = interval[1]
			}
		} else {
			merged = append(merged, interval)
		}
	}
	return merged
}

func main() {
	must(twoSum([]int{2, 7, 11, 15}, 9)[0] == 0 && twoSum([]int{2, 7, 11, 15}, 9)[1] == 1, "twoSum should find indices 0,1")
	must(twoSum([]int{1, 2}, 100) == nil, "twoSum should return nil when no pair matches")

	must(isPalindrome("A man, a plan, a canal: Panama") == true, "should be a palindrome")
	must(isPalindrome("race a car") == false, "should not be a palindrome")

	result := mergeIntervals([][]int{{1, 3}, {2, 6}, {8, 10}, {15, 18}})
	must(len(result) == 3 && result[0][0] == 1 && result[0][1] == 6, "overlapping intervals should merge")

	fmt.Println("ok")
}

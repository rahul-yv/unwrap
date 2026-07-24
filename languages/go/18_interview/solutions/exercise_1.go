package main

import (
	"fmt"
	"sort"
)

func groupAnagrams(words []string) [][]string {
	groups := make(map[string][]string)
	for _, word := range words {
		key := []byte(word)
		sort.Slice(key, func(i, j int) bool { return key[i] < key[j] })
		groups[string(key)] = append(groups[string(key)], word)
	}

	result := make([][]string, 0, len(groups))
	for _, group := range groups {
		result = append(result, group)
	}
	return result
}

func main() {
	result := groupAnagrams([]string{"eat", "tea", "tan", "ate", "nat", "bat"})
	if len(result) != 3 {
		panic("groupAnagrams should produce 3 groups")
	}

	totalWords := 0
	for _, group := range result {
		totalWords += len(group)
	}
	if totalWords != 6 {
		panic("every input word should appear in exactly one group")
	}

	fmt.Println("ok")
}

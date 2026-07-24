package main

import (
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"sort"
	"strings"
)

func must(condition bool, message string) {
	if !condition {
		panic(message)
	}
}

var wordRe = regexp.MustCompile(`[a-z']+`)

type WordCount struct {
	Word  string
	Count int
}

func countWords(text string) map[string]int {
	counts := make(map[string]int)
	for _, w := range wordRe.FindAllString(strings.ToLower(text), -1) {
		counts[w]++
	}
	return counts
}

func topWords(path string, n int) ([]WordCount, error) {
	content, err := os.ReadFile(path)
	if err != nil {
		return nil, fmt.Errorf("topWords: %w", err)
	}

	counts := countWords(string(content))
	list := make([]WordCount, 0, len(counts))
	for word, count := range counts {
		list = append(list, WordCount{Word: word, Count: count})
	}
	sort.Slice(list, func(i, j int) bool {
		return list[i].Count > list[j].Count
	})
	if len(list) > n {
		list = list[:n]
	}
	return list, nil
}

func main() {
	counts := countWords("The cat sat. The cat ran!")
	must(counts["the"] == 2 && counts["cat"] == 2, "countWords should count occurrences")

	dir := os.TempDir()
	path := filepath.Join(dir, "unwrap-go-story.txt")
	err := os.WriteFile(path, []byte("dog dog cat bird dog cat"), 0644)
	must(err == nil, "WriteFile should succeed")
	defer os.Remove(path)

	top, err := topWords(path, 2)
	must(err == nil, "topWords should succeed")
	must(len(top) == 2 && top[0].Word == "dog" && top[0].Count == 3, "dog should be the top word")
	must(top[1].Word == "cat" && top[1].Count == 2, "cat should be second")

	_, err = topWords(filepath.Join(dir, "missing.txt"), 2)
	must(err != nil, "topWords should error on a missing file")

	fmt.Println("ok")
}

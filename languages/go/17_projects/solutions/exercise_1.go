package main

import (
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"sort"
	"strings"
)

var wordRe = regexp.MustCompile(`[a-z']+`)

type WordCount struct {
	Word  string
	Count int
}

func topWordsExcluding(path string, n int, stopwords map[string]bool) ([]WordCount, error) {
	content, err := os.ReadFile(path)
	if err != nil {
		return nil, fmt.Errorf("topWordsExcluding: %w", err)
	}

	counts := make(map[string]int)
	for _, w := range wordRe.FindAllString(strings.ToLower(string(content)), -1) {
		if stopwords[w] {
			continue
		}
		counts[w]++
	}

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
	dir := os.TempDir()
	path := filepath.Join(dir, "unwrap-go-stop.txt")
	os.WriteFile(path, []byte("the cat the dog the dog bird"), 0644)
	defer os.Remove(path)

	result, err := topWordsExcluding(path, 2, map[string]bool{"the": true})
	if err != nil {
		panic(err)
	}
	if len(result) != 2 || result[0].Word != "dog" || result[0].Count != 2 {
		panic("topWordsExcluding should exclude 'the' and rank 'dog' first")
	}

	fmt.Println("ok")
}

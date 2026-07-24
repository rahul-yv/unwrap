package main

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
)

func countLines(path string) (int, error) {
	file, err := os.Open(path)
	if err != nil {
		return 0, err
	}
	defer file.Close()

	count := 0
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		count++
	}
	if err := scanner.Err(); err != nil {
		return 0, err
	}
	return count, nil
}

func main() {
	dir := os.TempDir()
	path := filepath.Join(dir, "unwrap-go-count.txt")
	os.WriteFile(path, []byte("a\nb\nc\n"), 0644)
	defer os.Remove(path)

	n, err := countLines(path)
	if err != nil || n != 3 {
		panic("countLines should return 3")
	}
	fmt.Println("ok")
}

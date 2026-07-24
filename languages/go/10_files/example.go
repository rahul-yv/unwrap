package main

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
)

func must(condition bool, message string) {
	if !condition {
		panic(message)
	}
}

func main() {
	dir := os.TempDir()
	path := filepath.Join(dir, "unwrap-go-notes.txt")

	err := os.WriteFile(path, []byte("line one\nline two\n"), 0644)
	must(err == nil, "WriteFile should succeed")
	defer os.Remove(path)

	file, err := os.Open(path)
	must(err == nil, "Open should succeed")
	defer file.Close()

	lines := []string{}
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	must(scanner.Err() == nil, "scanner should not report an error")
	must(len(lines) == 2 && lines[0] == "line one" && lines[1] == "line two", "scanner should read both lines")

	content, err := os.ReadFile(path)
	must(err == nil, "ReadFile should succeed")
	must(string(content) == "line one\nline two\n", "ReadFile should return the full content")

	_, err = os.Open(filepath.Join(dir, "unwrap-go-missing.txt"))
	must(err != nil, "opening a missing file should return an error")
	must(os.IsNotExist(err), "the error should be a not-exist error")

	fmt.Println("ok")
}

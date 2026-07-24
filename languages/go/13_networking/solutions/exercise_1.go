package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"net/http/httptest"
	"time"
)

func fetchJSON(url string, target any) error {
	client := &http.Client{Timeout: 5 * time.Second}
	resp, err := client.Get(url)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("unexpected status: %d", resp.StatusCode)
	}
	return json.NewDecoder(resp.Body).Decode(target)
}

type Payload struct {
	OK bool `json:"ok"`
}

func main() {
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		json.NewEncoder(w).Encode(Payload{OK: true})
	}))
	defer server.Close()

	var result Payload
	if err := fetchJSON(server.URL, &result); err != nil || !result.OK {
		panic("fetchJSON should decode a successful response")
	}

	fmt.Println("ok")
}

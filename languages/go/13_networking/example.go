package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"net/http/httptest"
	"time"
)

func must(condition bool, message string) {
	if !condition {
		panic(message)
	}
}

type EchoRequest struct {
	Name string `json:"name"`
}

type EchoResponse struct {
	Echo string `json:"echo"`
}

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/api", func(w http.ResponseWriter, r *http.Request) {
		var req EchoRequest
		if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
			w.WriteHeader(http.StatusBadRequest)
			return
		}
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(EchoResponse{Echo: req.Name})
	})

	server := httptest.NewServer(mux)
	defer server.Close()

	client := &http.Client{Timeout: 5 * time.Second}

	body, _ := json.Marshal(EchoRequest{Name: "Ada"})
	resp, err := client.Post(server.URL+"/api", "application/json", bytes.NewReader(body))
	must(err == nil, "POST should succeed")
	defer resp.Body.Close()

	must(resp.StatusCode == http.StatusOK, "response should be 200")

	var result EchoResponse
	must(json.NewDecoder(resp.Body).Decode(&result) == nil, "response body should decode")
	must(result.Echo == "Ada", "echo should return the name")

	missing, err := client.Get(server.URL + "/missing")
	must(err == nil, "GET to /missing should still complete")
	defer missing.Body.Close()
	must(missing.StatusCode == http.StatusNotFound, "unregistered route should 404")

	fmt.Println("ok")
}

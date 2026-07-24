package solutions

import "testing"

func add(a, b int) int {
	return a + b
}

func TestAdd(t *testing.T) {
	cases := []struct {
		name     string
		a, b     int
		expected int
	}{
		{"zero", 0, 0, 0},
		{"cancelling values", -1, 1, 0},
	}

	for _, c := range cases {
		t.Run(c.name, func(t *testing.T) {
			if got := add(c.a, c.b); got != c.expected {
				t.Errorf("add(%d, %d) = %d, want %d", c.a, c.b, got, c.expected)
			}
		})
	}
}

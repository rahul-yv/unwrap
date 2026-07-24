package main

import "fmt"

type Rectangle struct {
	Width, Height float64
}

func (r Rectangle) Area() float64 {
	return r.Width * r.Height
}

func (r Rectangle) Equals(other Rectangle) bool {
	return r.Width == other.Width && r.Height == other.Height
}

func main() {
	r := Rectangle{Width: 3, Height: 4}
	if r.Area() != 12 {
		panic("Area should be 12")
	}
	if !r.Equals(Rectangle{Width: 3, Height: 4}) {
		panic("Equals should be true for matching dimensions")
	}
	if r.Equals(Rectangle{Width: 4, Height: 3}) {
		panic("Equals should be false for swapped dimensions")
	}
	fmt.Println("ok")
}

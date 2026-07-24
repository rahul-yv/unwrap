package main

import "fmt"

func must(condition bool, message string) {
	if !condition {
		panic(message)
	}
}

type Animal struct {
	Name string
}

func (a Animal) Describe() string {
	return "an animal named " + a.Name
}

type Speaker interface {
	Speak() string
}

type Dog struct {
	Animal
}

func (d Dog) Speak() string {
	return d.Name + " says Woof"
}

type Counter struct {
	count int
}

func (c *Counter) Increment() {
	c.count++
}

func (c Counter) valueIncrement() {
	c.count++ // mutates a copy, has no effect on the caller's Counter
}

func main() {
	dog := Dog{Animal{Name: "Rex"}}
	must(dog.Speak() == "Rex says Woof", "Dog should satisfy Speaker via Speak()")
	must(dog.Describe() == "an animal named Rex", "embedded Animal's method should be promoted")

	var s Speaker = dog // implicit interface satisfaction, no `implements`
	must(s.Speak() == "Rex says Woof", "Dog should be usable as a Speaker")

	c := Counter{}
	c.valueIncrement()
	must(c.count == 0, "value receiver should not mutate the original")

	c.Increment()
	must(c.count == 1, "pointer receiver should mutate the original")

	fmt.Println("ok")
}

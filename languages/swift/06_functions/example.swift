func greet(_ name: String, greeting: String = "Hello") -> String {
    "\(greeting), \(name)!"
}

func makeAdder(_ n: Int) -> (Int) -> Int {
    { x in x + n }
}

func makeCounter() -> () -> Int {
    var count = 0
    return {
        count += 1
        return count
    }
}

assert(greet("Ada") == "Hello, Ada!")
assert(greet("Ada", greeting: "Hi") == "Hi, Ada!")

let addFive: (Int) -> Int = { x in x + 5 }
assert(addFive(3) == 8)

let addTen = makeAdder(10)
assert(addTen(5) == 15)

let counter = makeCounter()
assert(counter() == 1)
assert(counter() == 2)

print("ok")

let age = 25
var name = "Ada"
name = "Grace"
assert(name == "Grace")

let maxRetries: Int = 3
assert(maxRetries == 3)

var point = (x: 3, y: 4)
assert(point.x == 3 && point.y == 4)

let numbers = [1, 2, 3]
var copy = numbers
copy.append(4)
assert(numbers == [1, 2, 3])
assert(copy == [1, 2, 3, 4])

assert(age == 25)
print("ok")

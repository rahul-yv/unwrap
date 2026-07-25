struct Point: Equatable {
    let x: Int
    let y: Int
    static func + (lhs: Point, rhs: Point) -> Point {
        Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

let sum = 3 + 4
let remainder = 10 % 3
assert(sum == 7 && remainder == 1)

let inRange = (1...10).contains(5)
let notInRange = !(1...10).contains(15)
assert(inRange && notInRange)

let a = true, b = false
assert((a && b) == false)
assert((a || b) == true)

let x: Int? = nil
let y = x ?? -1
assert(y == -1)

let p = Point(x: 1, y: 2) + Point(x: 3, y: 4)
assert(p == Point(x: 4, y: 6))

print("ok")

protocol Greetable {
    var name: String { get }
    func greet() -> String
}

struct Person: Greetable {
    let name: String
    func greet() -> String { "Hello, \(name)!" }
}

struct Point: Equatable {
    var x: Int
    var y: Int
}

enum Shape {
    case circle(radius: Double)
    case square(side: Double)
}

func area(_ shape: Shape) -> Double {
    switch shape {
    case .circle(let radius): return Double.pi * radius * radius
    case .square(let side): return side * side
    }
}

let ada = Person(name: "Ada")
assert(ada.greet() == "Hello, Ada!")

let p1 = Point(x: 1, y: 2)
var p2 = p1
p2.y = 3
assert(p1 == Point(x: 1, y: 2))
assert(p2 == Point(x: 1, y: 3))
assert(p1 != p2)

let circleArea = area(.circle(radius: 2.0))
assert(circleArea > 12.5 && circleArea < 12.6)
assert(area(.square(side: 3.0)) == 9.0)

print("ok")

enum Shape {
    case circle(radius: Double)
    case rectangle(width: Double, height: Double)
}

func perimeter(_ shape: Shape) -> Double {
    switch shape {
    case .circle(let radius): return 2 * Double.pi * radius
    case .rectangle(let width, let height): return 2 * (width + height)
    }
}

let circlePerimeter = perimeter(.circle(radius: 1.0))
assert(circlePerimeter > 6.28 && circlePerimeter < 6.29)
assert(perimeter(.rectangle(width: 2.0, height: 3.0)) == 10.0)
print("ok")

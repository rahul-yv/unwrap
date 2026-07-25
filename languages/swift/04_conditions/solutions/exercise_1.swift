func grade(_ score: Int) -> String {
    switch score {
    case 90...: return "A"
    case 80..<90: return "B"
    case 70..<80: return "C"
    default: return "F"
    }
}

assert(grade(95) == "A")
assert(grade(85) == "B")
assert(grade(75) == "C")
assert(grade(50) == "F")
print("ok")

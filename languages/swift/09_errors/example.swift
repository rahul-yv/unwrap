enum MathError: Error, Equatable {
    case divisionByZero
}

func divide(_ a: Int, _ b: Int) throws -> Int {
    if b == 0 { throw MathError.divisionByZero }
    return a / b
}

func safeDivide(_ a: Int, _ b: Int) -> Result<Int, MathError> {
    b == 0 ? .failure(.divisionByZero) : .success(a / b)
}

let result: Int
do {
    result = try divide(10, 0)
} catch MathError.divisionByZero {
    result = -1
} catch {
    result = -2
}
assert(result == -1)

let ok = try? divide(10, 2)
assert(ok == 5)

let bad = try? divide(10, 0)
assert(bad == nil)

let forced = try! divide(10, 2)
assert(forced == 5)

switch safeDivide(10, 0) {
case .success: assertionFailure("should have failed")
case .failure(let error): assert(error == .divisionByZero)
}

print("ok")

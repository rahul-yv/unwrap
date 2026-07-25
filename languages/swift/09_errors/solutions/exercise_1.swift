enum ParseError: Error {
    case invalidInput
}

func safeParseInt(_ s: String) -> Result<Int, Error> {
    guard let value = Int(s) else {
        return .failure(ParseError.invalidInput)
    }
    return .success(value)
}

switch safeParseInt("42") {
case .success(let value): assert(value == 42)
case .failure: assertionFailure("should have succeeded")
}

switch safeParseInt("not a number") {
case .success: assertionFailure("should have failed")
case .failure: break
}

print("ok")

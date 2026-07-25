final class TestRunner {
    private var run = 0
    private var failed = 0

    func check(_ condition: Bool, _ name: String) {
        run += 1
        if condition {
            print("PASS: \(name)")
        } else {
            failed += 1
            print("FAIL: \(name)")
        }
    }

    func summary() -> Int32 {
        print("\(run - failed)/\(run) passed")
        return failed == 0 ? 0 : 1
    }
}

func add(_ a: Int, _ b: Int) -> Int { a + b }

let t = TestRunner()
t.check(add(2, 3) == 5, "adds positive numbers")
t.check(add(-2, -3) == -5, "adds negative numbers")
let exitCode = t.summary()
assert(exitCode == 0)
print("ok")

actor Counter {
    private var value = 0
    func increment() { value += 1 }
    func get() -> Int { value }
}

func run() async {
    let counter = Counter()
    await withTaskGroup(of: Void.self) { group in
        for _ in 0..<10 {
            group.addTask { await counter.increment() }
        }
    }
    let result = await counter.get()
    assert(result == 10)

    let sum = await withTaskGroup(of: Int.self, returning: Int.self) { group in
        group.addTask { (1...5).reduce(0, +) }
        group.addTask { (6...10).reduce(0, +) }
        var total = 0
        for await partial in group { total += partial }
        return total
    }
    assert(sum == 55)

    print("ok")
}

await run()

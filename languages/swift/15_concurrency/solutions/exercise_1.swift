func sumConcurrently(_ numbers: [Int]) async -> Int {
    let mid = numbers.count / 2
    let left = Array(numbers[..<mid])
    let right = Array(numbers[mid...])

    return await withTaskGroup(of: Int.self, returning: Int.self) { group in
        group.addTask { left.reduce(0, +) }
        group.addTask { right.reduce(0, +) }
        var total = 0
        for await partial in group { total += partial }
        return total
    }
}

func run() async {
    let result = await sumConcurrently([1, 2, 3, 4, 5, 6])
    assert(result == 21)
    print("ok")
}

await run()

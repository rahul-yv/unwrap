func twoSum(_ nums: [Int], _ target: Int) -> (Int, Int)? {
    var seen: [Int: Int] = [:]
    for (i, n) in nums.enumerated() {
        if let j = seen[target - n] {
            return (j, i)
        }
        seen[n] = i
    }
    return nil
}

func isPalindrome(_ s: String) -> Bool {
    let chars = s.lowercased().filter { $0.isLetter || $0.isNumber }
    return chars == String(chars.reversed())
}

func mergeIntervals(_ intervals: [[Int]]) -> [[Int]] {
    if intervals.isEmpty { return [] }

    let sorted = intervals.sorted { $0[0] < $1[0] }
    var merged = [sorted[0]]

    for interval in sorted.dropFirst() {
        if interval[0] <= merged[merged.count - 1][1] {
            merged[merged.count - 1][1] = max(merged[merged.count - 1][1], interval[1])
        } else {
            merged.append(interval)
        }
    }
    return merged
}

let sumResult = twoSum([2, 7, 11, 15], 9)
assert(sumResult != nil && sumResult! == (0, 1))
assert(twoSum([1, 2], 100) == nil)

assert(isPalindrome("A man, a plan, a canal: Panama"))
assert(!isPalindrome("race a car"))

let merged = mergeIntervals([[1, 3], [2, 6], [8, 10], [15, 18]])
assert(merged == [[1, 6], [8, 10], [15, 18]])
assert(mergeIntervals([]).isEmpty)

print("ok")

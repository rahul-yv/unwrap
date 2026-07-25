fun twoSum(nums: IntArray, target: Int): Pair<Int, Int>? {
    val seen = mutableMapOf<Int, Int>()
    for (i in nums.indices) {
        val complement = target - nums[i]
        seen[complement]?.let { j -> return j to i }
        seen[nums[i]] = i
    }
    return null
}

fun isPalindrome(s: String): Boolean {
    val chars = s.filter { it.isLetterOrDigit() }.lowercase()
    return chars == chars.reversed()
}

fun mergeIntervals(intervals: List<IntArray>): List<IntArray> {
    if (intervals.isEmpty()) return emptyList()

    val sorted = intervals.sortedBy { it[0] }
    val merged = mutableListOf(sorted[0])

    for (interval in sorted.drop(1)) {
        val last = merged.last()
        if (interval[0] <= last[1]) {
            last[1] = maxOf(last[1], interval[1])
        } else {
            merged.add(interval)
        }
    }
    return merged
}

fun main() {
    check(twoSum(intArrayOf(2, 7, 11, 15), 9) == (0 to 1))
    check(twoSum(intArrayOf(1, 2), 100) == null)

    check(isPalindrome("A man, a plan, a canal: Panama"))
    check(!isPalindrome("race a car"))

    val merged = mergeIntervals(listOf(intArrayOf(1, 3), intArrayOf(2, 6), intArrayOf(8, 10), intArrayOf(15, 18)))
    check(merged.map { it.toList() } == listOf(listOf(1, 6), listOf(8, 10), listOf(15, 18)))
    check(mergeIntervals(emptyList()).isEmpty())

    println("ok")
}

List<int>? twoSum(List<int> nums, int target) {
  final seen = <int, int>{};
  for (int i = 0; i < nums.length; i++) {
    final complement = target - nums[i];
    if (seen.containsKey(complement)) {
      return [seen[complement]!, i];
    }
    seen[nums[i]] = i;
  }
  return null;
}

bool isPalindrome(String s) {
  final chars = s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
  return chars == chars.split('').reversed.join();
}

List<List<int>> mergeIntervals(List<List<int>> intervals) {
  if (intervals.isEmpty) return [];

  final sorted = List<List<int>>.from(intervals)
    ..sort((a, b) => a[0].compareTo(b[0]));
  final merged = [List<int>.from(sorted[0])];

  for (final interval in sorted.skip(1)) {
    final last = merged.last;
    if (interval[0] <= last[1]) {
      last[1] = last[1] > interval[1] ? last[1] : interval[1];
    } else {
      merged.add(List<int>.from(interval));
    }
  }
  return merged;
}

void main() {
  final sumResult = twoSum([2, 7, 11, 15], 9);
  assert(sumResult != null && sumResult[0] == 0 && sumResult[1] == 1);
  assert(twoSum([1, 2], 100) == null);

  assert(isPalindrome("A man, a plan, a canal: Panama"));
  assert(!isPalindrome("race a car"));

  final merged = mergeIntervals([
    [1, 3],
    [2, 6],
    [8, 10],
    [15, 18]
  ]);
  assert(merged.length == 3);
  assert(merged[0][0] == 1 && merged[0][1] == 6);
  assert(mergeIntervals([]).isEmpty);

  print("ok");
}

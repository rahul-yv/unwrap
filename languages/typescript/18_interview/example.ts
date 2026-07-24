import assert from "node:assert";

function twoSum(nums: number[], target: number): [number, number] | null {
  const seen = new Map<number, number>();
  for (let i = 0; i < nums.length; i++) {
    const complement = target - nums[i];
    if (seen.has(complement)) return [seen.get(complement)!, i];
    seen.set(nums[i], i);
  }
  return null;
}

function isPalindrome(s: string): boolean {
  const isAlnum = (c: string): boolean => /[a-z0-9]/i.test(c);
  let left = 0;
  let right = s.length - 1;
  while (left < right) {
    while (left < right && !isAlnum(s[left])) left++;
    while (left < right && !isAlnum(s[right])) right--;
    if (s[left].toLowerCase() !== s[right].toLowerCase()) return false;
    left++;
    right--;
  }
  return true;
}

function mergeIntervals(intervals: number[][]): number[][] {
  if (intervals.length === 0) return [];
  const sorted = [...intervals].sort((a, b) => a[0] - b[0]);
  const merged: number[][] = [sorted[0]];
  for (const [start, end] of sorted.slice(1)) {
    const last = merged[merged.length - 1];
    if (start <= last[1]) {
      last[1] = Math.max(last[1], end);
    } else {
      merged.push([start, end]);
    }
  }
  return merged;
}

function demo(): void {
  assert.deepStrictEqual(twoSum([2, 7, 11, 15], 9), [0, 1]);
  assert.strictEqual(twoSum([1, 2], 100), null);

  assert.strictEqual(isPalindrome("A man, a plan, a canal: Panama"), true);
  assert.strictEqual(isPalindrome("race a car"), false);

  assert.deepStrictEqual(
    mergeIntervals([
      [1, 3],
      [2, 6],
      [8, 10],
      [15, 18],
    ]),
    [
      [1, 6],
      [8, 10],
      [15, 18],
    ]
  );
  assert.deepStrictEqual(mergeIntervals([]), []);
}

demo();
console.log("ok");

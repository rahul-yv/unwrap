import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Example {
    static void check(boolean condition, String message) {
        if (!condition) {
            throw new RuntimeException(message);
        }
    }

    static int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> seen = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (seen.containsKey(complement)) {
                return new int[] {seen.get(complement), i};
            }
            seen.put(nums[i], i);
        }
        return null;
    }

    static boolean isPalindrome(String s) {
        int left = 0, right = s.length() - 1;
        while (left < right) {
            while (left < right && !Character.isLetterOrDigit(s.charAt(left))) left++;
            while (left < right && !Character.isLetterOrDigit(s.charAt(right))) right--;
            if (Character.toLowerCase(s.charAt(left)) != Character.toLowerCase(s.charAt(right))) return false;
            left++;
            right--;
        }
        return true;
    }

    static List<int[]> mergeIntervals(int[][] intervals) {
        List<int[]> result = new ArrayList<>();
        if (intervals.length == 0) return result;

        int[][] sorted = intervals.clone();
        java.util.Arrays.sort(sorted, (a, b) -> a[0] - b[0]);

        int[] current = sorted[0].clone();
        for (int i = 1; i < sorted.length; i++) {
            if (sorted[i][0] <= current[1]) {
                current[1] = Math.max(current[1], sorted[i][1]);
            } else {
                result.add(current);
                current = sorted[i].clone();
            }
        }
        result.add(current);
        return result;
    }

    public static void main(String[] args) {
        int[] result = twoSum(new int[] {2, 7, 11, 15}, 9);
        check(result[0] == 0 && result[1] == 1, "twoSum should find indices 0,1");
        check(twoSum(new int[] {1, 2}, 100) == null, "twoSum should return null when no pair matches");

        check(isPalindrome("A man, a plan, a canal: Panama"), "should be a palindrome");
        check(!isPalindrome("race a car"), "should not be a palindrome");

        List<int[]> merged = mergeIntervals(new int[][] {{1, 3}, {2, 6}, {8, 10}, {15, 18}});
        check(merged.size() == 3 && merged.get(0)[0] == 1 && merged.get(0)[1] == 6, "overlapping intervals should merge");

        System.out.println("ok");
    }
}

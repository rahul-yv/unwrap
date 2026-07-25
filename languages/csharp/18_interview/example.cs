using System.Diagnostics;

(int, int)? TwoSum(int[] nums, int target)
{
	var seen = new Dictionary<int, int>();
	for (int i = 0; i < nums.Length; i++)
	{
		if (seen.TryGetValue(target - nums[i], out int j))
		{
			return (j, i);
		}
		seen[nums[i]] = i;
	}
	return null;
}

bool IsPalindrome(string s)
{
	var chars = s.Where(char.IsLetterOrDigit).Select(char.ToLowerInvariant).ToList();
	return chars.SequenceEqual(chars.AsEnumerable().Reverse());
}

List<(int, int)> MergeIntervals(List<(int, int)> intervals)
{
	if (intervals.Count == 0) return new List<(int, int)>();

	var sorted = intervals.OrderBy(iv => iv.Item1).ToList();
	var merged = new List<(int, int)> { sorted[0] };

	foreach (var interval in sorted.Skip(1))
	{
		var last = merged[^1];
		if (interval.Item1 <= last.Item2)
		{
			merged[^1] = (last.Item1, Math.Max(last.Item2, interval.Item2));
		}
		else
		{
			merged.Add(interval);
		}
	}
	return merged;
}

Debug.Assert(TwoSum([2, 7, 11, 15], 9) == (0, 1));
Debug.Assert(TwoSum([1, 2], 100) is null);

Debug.Assert(IsPalindrome("A man, a plan, a canal: Panama"));
Debug.Assert(!IsPalindrome("race a car"));

var merged = MergeIntervals([(1, 3), (2, 6), (8, 10), (15, 18)]);
Debug.Assert(merged.SequenceEqual([(1, 6), (8, 10), (15, 18)]));
Debug.Assert(MergeIntervals([]).Count == 0);

Console.WriteLine("ok");

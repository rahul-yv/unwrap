using System.Diagnostics;

var nums = new List<int> { 3, 1, 2 };
nums.Add(4);
nums.Sort();
Debug.Assert(nums.SequenceEqual(new[] { 1, 2, 3, 4 }));
Debug.Assert(nums.Sum() == 10);

var counts = new Dictionary<string, int>();
counts["a"] = counts.GetValueOrDefault("a") + 1;
counts["a"] = counts.GetValueOrDefault("a") + 1;
counts["b"] = counts.GetValueOrDefault("b") + 1;
Debug.Assert(counts["a"] == 2);
Debug.Assert(counts["b"] == 1);

// TryGetValue: safe lookup without exceptions
Debug.Assert(counts.TryGetValue("a", out int a) && a == 2);
Debug.Assert(!counts.TryGetValue("missing", out int _));

// indexing a missing key throws
bool threw = false;
try
{
    _ = counts["missing"];
}
catch (KeyNotFoundException)
{
    threw = true;
}
Debug.Assert(threw);

// LINQ
var evens = nums.Where(n => n % 2 == 0).ToList();
Debug.Assert(evens.SequenceEqual(new[] { 2, 4 }));

var set = new HashSet<int> { 1, 2, 2, 3 };
Debug.Assert(set.Count == 3);

Console.WriteLine("ok");

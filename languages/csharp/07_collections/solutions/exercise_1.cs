using System.Diagnostics;

static Dictionary<string, int> WordCounts(string[] words)
{
    var counts = new Dictionary<string, int>();
    foreach (var word in words)
    {
        counts[word] = counts.GetValueOrDefault(word) + 1;
    }
    return counts;
}

var result = WordCounts(new[] { "a", "b", "a" });
Debug.Assert(result["a"] == 2);
Debug.Assert(result["b"] == 1);
Debug.Assert(result.Count == 2);

Console.WriteLine("ok");

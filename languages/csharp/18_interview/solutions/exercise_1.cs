using System.Diagnostics;

List<List<string>> GroupAnagrams(string[] words)
{
	var groups = new Dictionary<string, List<string>>();
	foreach (var word in words)
	{
		string key = new string(word.OrderBy(c => c).ToArray());
		if (!groups.TryGetValue(key, out var list))
		{
			list = new List<string>();
			groups[key] = list;
		}
		list.Add(word);
	}
	return groups.Values.ToList();
}

string[] words = ["eat", "tea", "tan", "ate", "nat", "bat"];
var groups = GroupAnagrams(words);

Debug.Assert(groups.Count == 3);
Debug.Assert(groups.Any(g => g.OrderBy(w => w).SequenceEqual(new[] { "ate", "eat", "tea" }.OrderBy(w => w))));
Debug.Assert(groups.Any(g => g.OrderBy(w => w).SequenceEqual(new[] { "nat", "tan" }.OrderBy(w => w))));
Debug.Assert(groups.Any(g => g.SequenceEqual(new[] { "bat" })));

Console.WriteLine("ok");

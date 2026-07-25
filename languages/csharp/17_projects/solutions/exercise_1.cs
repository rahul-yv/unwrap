using System.Diagnostics;

Dictionary<string, int> CountWords(string text)
{
	var counts = new Dictionary<string, int>();
	var current = new System.Text.StringBuilder();

	foreach (char c in text.ToLowerInvariant())
	{
		if (char.IsLetter(c) || c == '\'')
		{
			current.Append(c);
		}
		else if (current.Length > 0)
		{
			string word = current.ToString();
			counts[word] = counts.GetValueOrDefault(word) + 1;
			current.Clear();
		}
	}
	if (current.Length > 0)
	{
		string word = current.ToString();
		counts[word] = counts.GetValueOrDefault(word) + 1;
	}

	return counts;
}

List<(string Word, int Count)> TopWordsExcluding(string path, int n, IReadOnlySet<string> stopwords)
{
	string content = File.ReadAllText(path);
	var counts = CountWords(content);

	return counts
		.Where(kv => !stopwords.Contains(kv.Key))
		.Select(kv => (Word: kv.Key, Count: kv.Value))
		.OrderByDescending(e => e.Count)
		.Take(n)
		.ToList();
}

string path = Path.Combine(Path.GetTempPath(), $"unwrap-csharp-stopwords-{Environment.ProcessId}.txt");
File.WriteAllText(path, "the dog and the cat and the bird");

var stopwords = new HashSet<string> { "the", "and" };
var top = TopWordsExcluding(path, 2, stopwords);

Debug.Assert(top.Count == 2);
Debug.Assert(top[0] == ("dog", 1));

File.Delete(path);

Console.WriteLine("ok");

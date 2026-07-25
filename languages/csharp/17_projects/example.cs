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

List<(string Word, int Count)> TopWords(string path, int n)
{
	string content = File.ReadAllText(path);
	var counts = CountWords(content);

	return counts
		.Select(kv => (Word: kv.Key, Count: kv.Value))
		.OrderByDescending(e => e.Count)
		.Take(n)
		.ToList();
}

var counts = CountWords("The cat sat. The cat ran!");
Debug.Assert(counts["the"] == 2);
Debug.Assert(counts["cat"] == 2);

string path = Path.Combine(Path.GetTempPath(), $"unwrap-csharp-story-{Environment.ProcessId}.txt");
File.WriteAllText(path, "dog dog cat bird dog cat");

var top = TopWords(path, 2);
Debug.Assert(top.Count == 2);
Debug.Assert(top[0] == ("dog", 3));
Debug.Assert(top[1] == ("cat", 2));

string missing = Path.Combine(Path.GetTempPath(), "unwrap-csharp-missing.txt");
bool threw = false;
try
{
	TopWords(missing, 2);
}
catch (FileNotFoundException)
{
	threw = true;
}
Debug.Assert(threw);

File.Delete(path);

Console.WriteLine("ok");

using System.Diagnostics;

string path = Path.Combine(Path.GetTempPath(), "unwrap-csharp-notes.txt");

File.WriteAllText(path, "line one\nline two\n");

string content = File.ReadAllText(path);
Debug.Assert(content == "line one\nline two\n");

string[] lines = File.ReadAllLines(path);
Debug.Assert(lines.Length == 2);
Debug.Assert(lines[0] == "line one");

// File.ReadLines is lazy
int count = 0;
foreach (string line in File.ReadLines(path))
{
    count++;
}
Debug.Assert(count == 2);

// StreamReader with a using declaration (disposed at scope end)
using (var reader = new StreamReader(path))
{
    string? first = reader.ReadLine();
    Debug.Assert(first == "line one");
}

// a missing file throws
bool threw = false;
try
{
    File.ReadAllText(Path.Combine(Path.GetTempPath(), "unwrap-csharp-missing.txt"));
}
catch (FileNotFoundException)
{
    threw = true;
}
Debug.Assert(threw);

File.Delete(path);
Debug.Assert(!File.Exists(path));

Console.WriteLine("ok");

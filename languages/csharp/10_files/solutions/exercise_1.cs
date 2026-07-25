using System.Diagnostics;

static int CountLines(string path)
{
    if (!File.Exists(path))
    {
        return -1;
    }
    int count = 0;
    foreach (var _ in File.ReadLines(path))
    {
        count++;
    }
    return count;
}

string path = Path.Combine(Path.GetTempPath(), "unwrap-csharp-count.txt");
File.WriteAllText(path, "a\nb\nc\n");

Debug.Assert(CountLines(path) == 3);
Debug.Assert(CountLines(Path.Combine(Path.GetTempPath(), "unwrap-csharp-missing.txt")) == -1);

File.Delete(path);

Console.WriteLine("ok");

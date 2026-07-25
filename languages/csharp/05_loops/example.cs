using System.Diagnostics;

var seen = new List<int>();
for (int i = 0; i < 3; i++)
{
    seen.Add(i);
}
Debug.Assert(seen.SequenceEqual(new[] { 0, 1, 2 }));

var collected = new List<string>();
foreach (var item in new[] { "a", "b", "c" })
{
    collected.Add(item);
}
Debug.Assert(collected.SequenceEqual(new[] { "a", "b", "c" }));

int n = 0;
while (n < 3)
{
    n++;
}
Debug.Assert(n == 3);

int count = 0;
do
{
    count++;
} while (count < 3);
Debug.Assert(count == 3);

// custom iterator with yield return
static IEnumerable<int> Evens(int upTo)
{
    for (int i = 0; i <= upTo; i += 2)
    {
        yield return i;
    }
}
Debug.Assert(Evens(6).SequenceEqual(new[] { 0, 2, 4, 6 }));

Console.WriteLine("ok");

using System.Diagnostics;

static (int, int) Swap(int a, int b)
{
    return (b, a);
}

var result = Swap(1, 2);
Debug.Assert(result == (2, 1));

Console.WriteLine("ok");

using System.Diagnostics;

static int SumEven(int[] numbers)
{
    int total = 0;
    foreach (var n in numbers)
    {
        if (n % 2 == 0)
        {
            total += n;
        }
    }
    return total;
}

Debug.Assert(SumEven(new[] { 1, 2, 3, 4 }) == 6);
Debug.Assert(SumEven(new[] { 1, 3, 5 }) == 0);

Console.WriteLine("ok");

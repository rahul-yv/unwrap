using System.Diagnostics;

static int Describe(int? value)
{
    return value is int v ? v * 2 : -1;
}

Debug.Assert(Describe(5) == 10);
Debug.Assert(Describe(null) == -1);
Debug.Assert(Describe(0) == 0);

Console.WriteLine("ok");

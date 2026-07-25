using System.Diagnostics;

static double SafeDivide(double a, double b)
{
    if (b == 0)
    {
        throw new DivideByZeroException();
    }
    return a / b;
}

Debug.Assert(SafeDivide(10, 2) == 5);

bool threw = false;
try
{
    SafeDivide(10, 0);
}
catch (DivideByZeroException)
{
    threw = true;
}
Debug.Assert(threw);

Console.WriteLine("ok");

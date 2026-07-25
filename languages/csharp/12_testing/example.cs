int testsRun = 0;
int testsFailed = 0;

void Check(bool condition, string name)
{
    testsRun++;
    if (condition)
    {
        Console.WriteLine($"PASS: {name}");
    }
    else
    {
        testsFailed++;
        Console.WriteLine($"FAIL: {name}");
    }
}

static int Add(int a, int b) => a + b;

Check(Add(2, 3) == 5, "adds positive numbers");
Check(Add(-2, -3) == -5, "adds negative numbers");
Check(Add(0, 0) == 0, "adds zero");

Console.WriteLine($"{testsRun - testsFailed}/{testsRun} passed");
if (testsFailed == 0)
{
    Console.WriteLine("ok");
}
return testsFailed == 0 ? 0 : 1;

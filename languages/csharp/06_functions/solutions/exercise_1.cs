using System.Diagnostics;

static Func<int> MakeCounter()
{
    int count = 0;
    return () => ++count;
}

var counter = MakeCounter();
Debug.Assert(counter() == 1);
Debug.Assert(counter() == 2);
Debug.Assert(counter() == 3);

var other = MakeCounter();
Debug.Assert(other() == 1); // independent state

Console.WriteLine("ok");

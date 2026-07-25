using System.Diagnostics;

static string Grade(int score) => score switch
{
    >= 90 => "A",
    >= 80 => "B",
    >= 70 => "C",
    _ => "F",
};

Debug.Assert(Grade(95) == "A");
Debug.Assert(Grade(72) == "C");
Debug.Assert(Grade(40) == "F");

Console.WriteLine("ok");

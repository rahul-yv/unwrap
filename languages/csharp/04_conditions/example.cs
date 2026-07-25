using System.Diagnostics;

int score = 85;

string grade = score switch
{
    >= 90 => "A",
    >= 80 => "B",
    >= 70 => "C",
    _ => "F",
};
Debug.Assert(grade == "B");

string result = score >= 60 ? "pass" : "fail";
Debug.Assert(result == "pass");

// type + guard patterns
static string Classify(object value) => value switch
{
    string s => $"text:{s}",
    int n when n > 0 => "positive",
    int => "non-positive",
    _ => "other",
};
Debug.Assert(Classify("hi") == "text:hi");
Debug.Assert(Classify(5) == "positive");
Debug.Assert(Classify(-1) == "non-positive");
Debug.Assert(Classify(3.14) == "other");

// classic switch statement (no implicit fall-through)
static int Category(int n)
{
    switch (n)
    {
        case 1:
        case 2:
            return 12; // stacked empty cases are allowed
        default:
            return 0;
    }
}
Debug.Assert(Category(1) == 12 && Category(2) == 12 && Category(3) == 0);

Console.WriteLine("ok");

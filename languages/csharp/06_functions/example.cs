using System.Diagnostics;

static string Greet(string name, string greeting = "Hello") => $"{greeting}, {name}!";

Debug.Assert(Greet("Ada") == "Hello, Ada!");
Debug.Assert(Greet("Ada", greeting: "Hi") == "Hi, Ada!");

// out parameter
static bool TryParseInt(string s, out int result) => int.TryParse(s, out result);
Debug.Assert(TryParseInt("42", out int parsed) && parsed == 42);
Debug.Assert(!TryParseInt("nope", out int _));

// Func<> and a closure
static Func<int, int> MakeAdder(int n) => x => x + n;
var addFive = MakeAdder(5);
Debug.Assert(addFive(3) == 8);
Debug.Assert(addFive(10) == 15);

// LINQ with lambdas
var evens = new[] { 1, 2, 3, 4 }.Where(x => x % 2 == 0).ToList();
Debug.Assert(evens.SequenceEqual(new[] { 2, 4 }));

var doubled = new[] { 1, 2, 3 }.Select(x => x * 2).ToList();
Debug.Assert(doubled.SequenceEqual(new[] { 2, 4, 6 }));

Console.WriteLine("ok");

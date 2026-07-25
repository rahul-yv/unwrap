using System.Diagnostics;
using MyPackage;

static string ExampleUsage() => Greeter.Greet("World");

Debug.Assert(ExampleUsage() == "Hello, World!");

Console.WriteLine("ok");

namespace MyPackage
{
    public static class Greeter
    {
        public static string Greet(string name) => $"Hello, {name}!";
    }
}

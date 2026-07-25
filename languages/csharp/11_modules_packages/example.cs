using System.Diagnostics;
using MyPackage;

// use the type from the namespace defined below
Debug.Assert(Greeter.Greet("Ada") == "Hello, Ada!");

Console.WriteLine("ok");

namespace MyPackage
{
    public static class Greeter
    {
        public static string Greet(string name) => $"Hello, {name}!";

        // internal: usable within this assembly, but not exposed as public API
        internal static string InternalHelper() => "internal only";
    }
}

using System.Diagnostics;

string? name = null;
string display = name ?? "Anonymous";
Debug.Assert(display == "Anonymous");

name ??= "Default";
Debug.Assert(name == "Default");

int[]? items = null;
int? count = items?.Length;
Debug.Assert(count == null);

int[] present = { 1, 2, 3 };
int? presentCount = present?.Length;
Debug.Assert(presentCount == 3);

object value = "hello";
int len = 0;
if (value is string s)
{
    len = s.Length;
}
Debug.Assert(len == 5);

// is vs as
object number = 42;
string? asString = number as string;
Debug.Assert(asString == null); // cast fails -> null, no exception

int q = 7 / 2;
int r = 7 % 2;
Debug.Assert(q == 3 && r == 1);
Debug.Assert(7.0 / 2 == 3.5);

Console.WriteLine("ok");

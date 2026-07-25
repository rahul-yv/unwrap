using System.Diagnostics;

static string DisplayName(string? name)
{
    return string.IsNullOrEmpty(name) ? "Anonymous" : name;
}

Debug.Assert(DisplayName("Ada") == "Ada");
Debug.Assert(DisplayName(null) == "Anonymous");
Debug.Assert(DisplayName("") == "Anonymous");

Console.WriteLine("ok");

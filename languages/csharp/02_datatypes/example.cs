using System.Diagnostics;

int n = 10;
double pi = 3.14159;
decimal price = 19.99m;
bool ok = true;
Debug.Assert(n == 10 && ok);
Debug.Assert(pi > 3.14 && pi < 3.15);

// decimal is exact for base-10 values, unlike double
Debug.Assert(0.1m + 0.2m == 0.3m);
Debug.Assert(0.1 + 0.2 != 0.3); // double is not exact
Debug.Assert(price == 19.99m);

int? maybe = null;
Debug.Assert(!maybe.HasValue);
Debug.Assert((maybe ?? 0) == 0); // null-coalescing fallback

int? present = 42;
Debug.Assert(present.HasValue);
Debug.Assert(present.Value == 42);
Debug.Assert((present ?? 0) == 42);

Console.WriteLine("ok");

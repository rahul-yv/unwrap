using System.Diagnostics;

int age = 25;
var name = "Ada";
age = age + 1;
Debug.Assert(age == 26);
Debug.Assert(name == "Ada");

const int MaxRetries = 3;
Debug.Assert(MaxRetries == 3);

// value type: copied on assignment
int a = 5;
int b = a;
b = 10;
Debug.Assert(a == 5); // unchanged

// reference type: the reference is copied; both point at the same array
int[] arr1 = { 1, 2, 3 };
int[] arr2 = arr1;
arr2[0] = 99;
Debug.Assert(arr1[0] == 99); // shared mutation

// an independent copy requires constructing a new object
int[] arr3 = (int[])arr1.Clone();
arr3[0] = 1;
Debug.Assert(arr1[0] == 99); // still 99, arr3 is independent

Console.WriteLine("ok");

using System.Diagnostics;
using System.Linq;

async Task<int> SumConcurrentlyAsync(int[] numbers)
{
	int mid = numbers.Length / 2;
	var left = numbers[..mid];
	var right = numbers[mid..];

	Task<int> leftSum = Task.Run(() => left.Sum());
	Task<int> rightSum = Task.Run(() => right.Sum());

	int[] results = await Task.WhenAll(leftSum, rightSum);
	return results[0] + results[1];
}

int[] numbers = [1, 2, 3, 4, 5, 6];
int total = await SumConcurrentlyAsync(numbers);
Debug.Assert(total == 21);

Console.WriteLine("ok");

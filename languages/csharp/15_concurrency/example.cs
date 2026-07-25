using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;

int counter = 0;
object gate = new();
var tasks = new Task[10];
for (int i = 0; i < 10; i++)
{
	tasks[i] = Task.Run(() =>
	{
		lock (gate) { counter++; }
	});
}
await Task.WhenAll(tasks);
Debug.Assert(counter == 10);

int atomicCounter = 0;
var tasks2 = new Task[10];
for (int i = 0; i < 10; i++)
{
	tasks2[i] = Task.Run(() => Interlocked.Increment(ref atomicCounter));
}
await Task.WhenAll(tasks2);
Debug.Assert(atomicCounter == 10);

Console.WriteLine("ok");

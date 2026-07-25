using System.Diagnostics;
using System.Net;
using System.Net.Sockets;
using System.Text;

async Task<string> EchoOnceAsync(int port, string message)
{
	using var client = new TcpClient();
	await client.ConnectAsync(IPAddress.Loopback, port);
	using var stream = client.GetStream();

	byte[] outBytes = Encoding.UTF8.GetBytes(message);
	await stream.WriteAsync(outBytes);

	var buffer = new byte[64];
	int read = await stream.ReadAsync(buffer);
	return Encoding.UTF8.GetString(buffer, 0, read);
}

var listener = new TcpListener(IPAddress.Loopback, 0);
listener.Start();
int port = ((IPEndPoint)listener.LocalEndpoint).Port;

var serverTask = Task.Run(async () =>
{
	using var conn = await listener.AcceptTcpClientAsync();
	using var stream = conn.GetStream();
	var buffer = new byte[64];
	int read = await stream.ReadAsync(buffer);
	await stream.WriteAsync(buffer.AsMemory(0, read));
});

string result = await EchoOnceAsync(port, "ping");
Debug.Assert(result == "ping");

await serverTask;
listener.Stop();

Console.WriteLine("ok");

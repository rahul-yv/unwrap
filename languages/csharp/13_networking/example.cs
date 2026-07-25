using System.Diagnostics;
using System.Net;
using System.Net.Sockets;
using System.Text;

var listener = new TcpListener(IPAddress.Loopback, 0);
listener.Start();
int port = ((IPEndPoint)listener.LocalEndpoint).Port;

var serverTask = Task.Run(async () =>
{
	using var conn = await listener.AcceptTcpClientAsync();
	using var stream = conn.GetStream();
	var buffer = new byte[16];
	int read = await stream.ReadAsync(buffer);
	await stream.WriteAsync(buffer.AsMemory(0, read));
});

using (var client = new TcpClient())
{
	await client.ConnectAsync(IPAddress.Loopback, port);
	using var clientStream = client.GetStream();

	byte[] message = Encoding.UTF8.GetBytes("ping");
	await clientStream.WriteAsync(message);

	var response = new byte[16];
	int n = await clientStream.ReadAsync(response);
	string text = Encoding.UTF8.GetString(response, 0, n);

	Debug.Assert(text == "ping");
}

await serverTask;
listener.Stop();

Console.WriteLine("ok");

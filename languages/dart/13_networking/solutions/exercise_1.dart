import "dart:convert";
import "dart:io";

Future<String> echoOnce(int port, String message) async {
  final socket = await Socket.connect(InternetAddress.loopbackIPv4, port);
  socket.add(utf8.encode(message));
  final response = await socket.first;
  socket.close();
  return utf8.decode(response);
}

Future<void> main() async {
  final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
  final port = server.port;

  server.listen((client) {
    client.listen((data) {
      client.add(data);
      client.close();
    });
  });

  final result = await echoOnce(port, "ping");
  await server.close();

  assert(result == "ping");
  print("ok");
}

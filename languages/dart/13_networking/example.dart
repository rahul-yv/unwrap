import "dart:convert";
import "dart:io";

Future<void> main() async {
  final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
  final port = server.port;

  server.listen((client) {
    client.listen((data) {
      client.add(data);
      client.close();
    });
  });

  final socket = await Socket.connect(InternetAddress.loopbackIPv4, port);
  socket.add(utf8.encode("ping"));

  final response = await socket.first;
  final text = utf8.decode(response);
  assert(text == "ping");

  socket.close();
  await server.close();

  print("ok");
}

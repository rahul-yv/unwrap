import "dart:io";

int countLines(String path) => File(path).readAsLinesSync().length;

void main() {
  final file = File("${Directory.systemTemp.path}/unwrap-${pid}.txt");
  file.writeAsStringSync("a\nb\nc\n");

  assert(countLines(file.path) == 3);

  file.deleteSync();
  print("ok");
}

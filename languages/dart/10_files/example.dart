import "dart:io";

void main() {
  final file = File("${Directory.systemTemp.path}/unwrap-${pid}.txt");

  file.writeAsStringSync("line one\nline two\n");

  final content = file.readAsStringSync();
  assert(content == "line one\nline two\n");

  final lines = file.readAsLinesSync();
  assert(lines.join(",") == "line one,line two");

  file.writeAsStringSync("line three\n", mode: FileMode.append);
  assert(file.readAsLinesSync().join(",") == "line one,line two,line three");

  int lineCount = 0;
  for (final _ in file.readAsLinesSync()) {
    lineCount++;
  }
  assert(lineCount == 3);

  file.deleteSync();
  assert(!file.existsSync());

  print("ok");
}

import "dart:io";

Map<String, int> countWords(String text) {
  final counts = <String, int>{};
  final matches = RegExp(r"[a-z']+").allMatches(text.toLowerCase());
  for (final match in matches) {
    final word = match.group(0)!;
    counts[word] = (counts[word] ?? 0) + 1;
  }
  return counts;
}

List<MapEntry<String, int>> topWords(String path, int n) {
  final content = File(path).readAsStringSync();
  final counts = countWords(content);
  final entries = counts.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  return entries.take(n).toList();
}

void main() {
  final counts = countWords("The cat sat. The cat ran!");
  assert(counts["the"] == 2);
  assert(counts["cat"] == 2);

  final path = "${Directory.systemTemp.path}/unwrap-dart-story-${pid}.txt";
  File(path).writeAsStringSync("dog dog cat bird dog cat");

  final top = topWords(path, 2);
  assert(top[0].key == "dog" && top[0].value == 3);
  assert(top[1].key == "cat" && top[1].value == 2);

  bool threw = false;
  try {
    topWords("/tmp/unwrap-dart-missing-${pid}.txt", 2);
  } on FileSystemException {
    threw = true;
  }
  assert(threw);

  File(path).deleteSync();

  print("ok");
}

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

List<MapEntry<String, int>> topWordsExcluding(
    String path, int n, Set<String> stopwords) {
  final content = File(path).readAsStringSync();
  final counts = countWords(content)
    ..removeWhere((word, _) => stopwords.contains(word));
  final entries = counts.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  return entries.take(n).toList();
}

void main() {
  final path = "${Directory.systemTemp.path}/unwrap-dart-stopwords-${pid}.txt";
  File(path).writeAsStringSync("the dog and the cat and the bird");

  final top = topWordsExcluding(path, 2, {"the", "and"});

  assert(top.length == 2);
  assert(top.every((e) => e.value == 1));

  File(path).deleteSync();

  print("ok");
}

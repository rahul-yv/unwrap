List<List<String>> groupAnagrams(List<String> words) {
  final groups = <String, List<String>>{};
  for (final word in words) {
    final chars = word.split("")..sort();
    final key = chars.join();
    groups.putIfAbsent(key, () => []).add(word);
  }
  return groups.values.toList();
}

void main() {
  final words = ["eat", "tea", "tan", "ate", "nat", "bat"];
  final groups = groupAnagrams(words);

  assert(groups.length == 3);
  assert(groups.any((g) {
    final sorted = List<String>.from(g)..sort();
    return sorted.join(",") == "ate,eat,tea";
  }));
  assert(groups.any((g) {
    final sorted = List<String>.from(g)..sort();
    return sorted.join(",") == "nat,tan";
  }));
  assert(groups.any((g) => g.length == 1 && g[0] == "bat"));

  print("ok");
}

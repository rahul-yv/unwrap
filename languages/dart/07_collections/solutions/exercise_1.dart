Map<String, int> wordLengths(List<String> words) =>
    {for (final w in words) w: w.length};

void main() {
  final result = wordLengths(["a", "bb", "ccc"]);
  assert(result["a"] == 1 && result["bb"] == 2 && result["ccc"] == 3);
  print("ok");
}

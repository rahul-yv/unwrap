List<int> swap(int a, int b) => [b, a];

void main() {
  final result = swap(1, 2);
  assert(result[0] == 2 && result[1] == 1);
  print("ok");
}

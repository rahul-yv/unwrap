int safeLength(String? s) => s?.length ?? 0;

void main() {
  assert(safeLength(null) == 0);
  assert(safeLength("hello") == 5);
  print("ok");
}

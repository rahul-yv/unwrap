int? safeParseInt(String s) => int.tryParse(s);

void main() {
  assert(safeParseInt("42") == 42);
  assert(safeParseInt("not a number") == null);
  print("ok");
}

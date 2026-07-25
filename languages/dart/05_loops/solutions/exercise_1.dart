int sumEvens(int n) {
  int total = 0;
  for (int i = 0; i <= n; i += 2) {
    total += i;
  }
  return total;
}

void main() {
  assert(sumEvens(10) == 30);
  assert(sumEvens(0) == 0);
  print("ok");
}

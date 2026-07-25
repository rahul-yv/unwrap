int clamp(int value, int min, int max) {
  if (value < min) return min;
  if (value > max) return max;
  return value;
}

void main() {
  assert(clamp(5, 0, 10) == 5);
  assert(clamp(-5, 0, 10) == 0);
  assert(clamp(15, 0, 10) == 10);
  print("ok");
}

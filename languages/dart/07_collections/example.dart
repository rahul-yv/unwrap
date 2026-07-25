void main() {
  final numbers = [1, 2, 3, 4, 5];

  final doubled = numbers.map((n) => n * 2).toList();
  assert(doubled.join(",") == "2,4,6,8,10");

  final evens = numbers.where((n) => n.isEven).toList();
  assert(evens.join(",") == "2,4");

  final total = numbers.fold(0, (acc, n) => acc + n);
  assert(total == 15);

  final ages = {"Ada": 36, "Grace": 85};
  final adaAge = ages["Ada"];
  assert(adaAge == 36);
  final missing = ages["Nobody"] ?? 0;
  assert(missing == 0);

  final unique = {1, 2, 2, 3}.toList();
  assert(unique.join(",") == "1,2,3");

  final lazyResult = numbers.map((n) => n * 2).where((n) => n > 4).first;
  assert(lazyResult == 6);

  print("ok");
}

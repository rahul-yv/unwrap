import "dart:isolate";

Future<int> _sumInIsolate(List<int> numbers) async {
  final receivePort = ReceivePort();
  await Isolate.spawn(_isolateSum, [receivePort.sendPort, numbers]);
  final result = await receivePort.first;
  return result as int;
}

void _isolateSum(List<dynamic> args) {
  final sendPort = args[0] as SendPort;
  final numbers = args[1] as List<int>;
  sendPort.send(numbers.fold<int>(0, (a, b) => a + b));
}

Future<int> sumConcurrently(List<int> numbers) async {
  final mid = numbers.length ~/ 2;
  final left = numbers.sublist(0, mid);
  final right = numbers.sublist(mid);

  final results = await Future.wait([
    _sumInIsolate(left),
    _sumInIsolate(right),
  ]);
  return results[0] + results[1];
}

Future<void> main() async {
  final result = await sumConcurrently([1, 2, 3, 4, 5, 6]);
  assert(result == 21);
  print("ok");
}

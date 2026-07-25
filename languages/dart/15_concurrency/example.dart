import "dart:isolate";

Future<int> sumInIsolate(List<int> numbers) async {
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

Future<void> main() async {
  final isolateResult = await sumInIsolate([1, 2, 3]);
  assert(isolateResult == 6);

  final results = await Future.wait([
    Future.delayed(Duration.zero, () => 1),
    Future.delayed(Duration.zero, () => 2),
  ]);
  assert(results.reduce((a, b) => a + b) == 3);

  print("ok");
}

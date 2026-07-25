import "dart:math";
import "dart:convert";
import "dart:typed_data";
import "package:crypto/crypto.dart";

Uint8List pbkdf2(String password, Uint8List salt, int iterations, int keyLength) {
  final hmac = Hmac(sha256, utf8.encode(password));
  const hashLen = 32;
  final blocks = (keyLength / hashLen).ceil();
  final result = BytesBuilder();

  for (int i = 1; i <= blocks; i++) {
    var u = hmac.convert([...salt, ..._intToBytes(i)]).bytes;
    final t = Uint8List.fromList(u);
    for (int j = 1; j < iterations; j++) {
      u = hmac.convert(u).bytes;
      for (int k = 0; k < t.length; k++) {
        t[k] ^= u[k];
      }
    }
    result.add(t);
  }
  return result.toBytes().sublist(0, keyLength);
}

Uint8List _intToBytes(int i) =>
    Uint8List(4)..buffer.asByteData().setInt32(0, i, Endian.big);

Uint8List randomBytes(int count) {
  final random = Random.secure();
  return Uint8List.fromList(List.generate(count, (_) => random.nextInt(256)));
}

bool secureCompare(List<int> a, List<int> b) {
  if (a.length != b.length) return false;
  int result = 0;
  for (int i = 0; i < a.length; i++) {
    result |= a[i] ^ b[i];
  }
  return result == 0;
}

void main() {
  final salt = randomBytes(16);
  final hash = pbkdf2("hunter2", salt, 100000, 32);

  final correctAttempt = pbkdf2("hunter2", salt, 100000, 32);
  assert(secureCompare(hash, correctAttempt));

  final wrongAttempt = pbkdf2("wrong-password", salt, 100000, 32);
  assert(!secureCompare(hash, wrongAttempt));

  print("ok");
}

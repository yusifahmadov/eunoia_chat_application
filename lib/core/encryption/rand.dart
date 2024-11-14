import 'dart:math' as math;
import 'dart:typed_data';

final math.Random _r = math.Random.secure();

int randomInt(int max) {
  int r;
  do {
    r = _randomInt(max.bitLength);
  } while (r >= max);
  return r;
}

int _randomInt(int numBits) {
  List<int> bytes = _randomBytes(numBits);
  int r = 0;
  for (final b in bytes) {
    r = (r << 8) + b;
  }
  return r;
}

List<int> _randomBytes(int numBits) {
  if (numBits < 0) {
    throw ArgumentError.value(numBits, 'numBits must be non-negative');
  }

  int numBytes = (numBits + 7) ~/ 8;
  Uint8List randomBytes = Uint8List(numBytes);

  for (var i = 0; i < randomBytes.length; i++) {
    randomBytes[i] = _r.nextInt(255);
  }
  int excessBits = 8 * numBytes - numBits;
  randomBytes[0] &= (1 << (8 - excessBits)) - 1;

  return randomBytes;
}

import 'dart:math';

import 'package:eunoia_chat_application/core/encryption/extension.dart';

class DhGroup {
  final BigInt prime;

  final BigInt generator;

  DhGroup(this.prime, this.generator);

  factory DhGroup.byGroupId(int groupId) {
    BigInt p, g;
    switch (groupId) {
      case 1:
        p = BigInt.parse(
            'FFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE45B3DC2007CB8A163BF0598DA48361C55D39A69163FA8FD24CF5F83655D23DCA3AD961C62F356208552BB9ED529077096966D670C354E4ABC9804F1746C08CA18217C32905E462E36CE3BE39E772C180E86039B2783A2EC07A28FB5C55DF06F4C52C9DE2BCBF6955817183995497CEA956AE515D2261898FA051015728E5A8AAAC42DAD33170D04507A33A85521ABDF1CBA64ECFB850458DBEF0A8AEA71575D060C7DB3970F85A6E1E4C7ABF5AE8CDB0933D71E8C94E04A25619DCEE3D2261AD2EE6BF12FFA06D98A0864D87602733EC86A64521F2B18177B200CBBE117577A615D6C770988C0BAD946E208E24FA074E5AB3143DB5BFCE0FD108E4B82D120A93AD2CAFFFFFFFFFFFFFFFF',
            radix: 16);
        g = BigInt.from(2);
        break;
      case 2:
        p = BigInt.parse(
            'FFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE65381FFFFFFFFFFFFFFFF',
            radix: 16);
        g = BigInt.from(2);
        break;
      case 14:
        p = BigInt.parse(
            'FFFFFFFFFFFFFFFFC90FDAA22168C234C4C6628B80DC1CD129024E088A67CC74020BBEA63B139B22514A08798E3404DDEF9519B3CD3A431B302B0A6DF25F14374FE1356D6D51C245E485B576625E7EC6F44C42E9A637ED6B0BFF5CB6F406B7EDEE386BFB5A899FA5AE9F24117C4B1FE649286651ECE45B3DC2007CB8A163BF0598DA48361C55D39A69163FA8FD24CF5F83655D23DCA3AD961C62F356208552BB9ED529077096966D670C354E4ABC9804F1746C08CA18217C32905E462E36CE3BE39E772C180E86039B2783A2EC07A28FB5C55DF06F4C52C9DE2BCBF6955817183995497CEA956AE515D2261898FA051015728E5A8AACAA68FFFFFFFFFFFFFFFF',
            radix: 16);
        g = BigInt.from(2);
        break;
      default:
        throw ArgumentError.value(groupId, 'Unknown groupId');
    }
    return DhGroup(p, g);
  }
  static BigInt generatePrivateValueWithLength(int length) {
    Random random = Random.secure();

    BigInt lowerBound = BigInt.two.pow(length - 1);
    BigInt upperBound = BigInt.two * lowerBound;
    BigInt generated;

    do {
      generated = random.nextBigInt(length);
    } while (generated < lowerBound || generated >= upperBound);

    return generated;
  }

  static BigInt generatePrivateValueFromP(BigInt p) {
    Random random = Random.secure();

    BigInt lowerBound = BigInt.zero;
    BigInt upperBound = p - BigInt.one;
    BigInt generated;

    do {
      generated = random.nextBigInt(upperBound.bitLength);
    } while (generated <= lowerBound || generated >= upperBound);

    return generated;
  }

  DhKey generateKey() {
    BigInt privateKey = generatePrivateValueWithLength(prime.bitLength);
    BigInt publicKey = generator.modPow(privateKey, prime);
    return DhKey(privateKey: privateKey, publicKey: publicKey, group: this);
  }
}

class DhKey {
  final BigInt privateKey;
  final BigInt publicKey;
  final DhGroup group;
  final String? userId;
  DhKey(
      {required this.privateKey,
      required this.publicKey,
      required this.group,
      this.userId});

  // Generate a new Diffie-Hellman key pair
  factory DhKey.generate(DhGroup group) {
    BigInt privateKey = _generatePrivateKey(group.prime);
    BigInt publicKey = group.generator.modPow(privateKey, group.prime);
    return DhKey(group: group, privateKey: privateKey, publicKey: publicKey);
  }

  // Compute shared secret with another user's public key
  BigInt computeSharedSecret(BigInt otherPublicKey) {
    return otherPublicKey.modPow(privateKey, group.prime);
  }

  static BigInt _generatePrivateKey(BigInt prime) {
    final random = Random.secure();
    return BigInt.from(random.nextInt(prime.toInt() - 1) + 1);
  }

  Map<String, dynamic> toJson({required String userId}) {
    return {
      'userId': userId,
      'privateKey': privateKey.toString(),
      'publicKey': publicKey.toString(),
      'group': {
        'prime': group.prime.toString(),
        'generator': group.generator.toString(),
      }
    };
  }

  factory DhKey.fromJson(Map<String, dynamic> json) {
    return DhKey(
      group: DhGroup(
        BigInt.parse(json['group']['prime']),
        BigInt.parse(json['group']['generator']),
      ),
      privateKey: BigInt.parse(json['privateKey']),
      publicKey: BigInt.parse(json['publicKey']),
      userId: json['userId'],
    );
  }
}

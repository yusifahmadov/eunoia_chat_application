import 'package:diffie_hellman/src/engines/dh_engine.dart';
import 'package:diffie_hellman/src/groups/dh_group.dart';
import 'package:diffie_hellman/src/keys/dh_key.dart';
import 'package:diffie_hellman/src/keys/dh_private_key.dart';
import 'package:diffie_hellman/src/keys/dh_public_key.dart';
import 'package:diffie_hellman/src/spec/dh_parameter.dart';
import 'package:diffie_hellman/src/utils/dh_random_generator.dart';
import 'package:meta/meta.dart';

/// Concrete implementation of [DhEngine].
/// Use the constructor DhPkcs3Engine.fromGroup() with a specific group ID
/// for predefined engine objects based on https://www.ietf.org/rfc/rfc3526.txt
class DhPkcs3Engine implements DhEngine {
  /// The Diffie-Hellman parameters used by this engine
  final DhParameter parameter;

  DhKeyPair? _keyPair;
  BigInt? _secretKey;

  /// Must call generateKeyPair() method before accessing this value.
  @override
  DhPublicKey? get publicKey => _keyPair?.publicKey;

  /// Must call generateKeyPair() method before accessing this value.
  @override
  DhPrivateKey? get privateKey => _keyPair?.privateKey;

  @override
  DhKeyPair? get keyPair => _keyPair;

  // Must call computeSecretKey() method before accessing this value.
  @override
  BigInt? get secretKey => _secretKey;

  DhPkcs3Engine._({
    required this.parameter,
    DhKeyPair? keyPair,
  }) : _keyPair = keyPair;

  /// Constructs a [DhPkcs3Engine] instance using a [DhGroup].
  factory DhPkcs3Engine.fromGroup(DhGroup group) =>
      DhPkcs3Engine._(parameter: group.parameter);

  /// Constructs a [DhPkcs3Engine] instance using a [DhParameter].
  factory DhPkcs3Engine.fromParameter(DhParameter parameter) =>
      DhPkcs3Engine._(parameter: parameter);

  /// Constructs a [DhPkcs3Engine] instance using a [DhKeyPair].
  factory DhPkcs3Engine.fromKeyPair(DhKeyPair keyPair) => DhPkcs3Engine._(
        parameter: keyPair.parameter,
        keyPair: keyPair,
      );

  /// Compute the secret key using the other party public key
  /// If the [keyPair] is not yet generated, a [StateError] is thrown.
  @override
  BigInt computeSecretKey(BigInt otherPublicValue) {
    if (_keyPair == null) {
      throw StateError('Key pair not generated. Call generateKeyPair() method first');
    }
    return otherPublicValue.modPow(
      privateKey!.value,
      parameter.p,
    );
  }

  /// Generate [publicKey] and [privateKey] based on the [parameterSpec] of this engine.
  ///
  /// If the platform cannot provide a cryptographically secure source of random numbers, an [UnsupportedError] is thrown.
  @override
  DhKeyPair generateKeyPair() {
    DhPrivateKey privateKey = generatePrivateKey();
    return _keyPair = DhKeyPair(
      publicKey: generatePublicKey(privateKey.value),
      privateKey: privateKey,
    );
  }

  @override
  @protected
  DhPrivateKey generatePrivateKey() => DhPrivateKey(
        parameter.l != null
            ? DhRandomGenerator.generatePrivateValueWithLength(parameter.l!)
            : DhRandomGenerator.generatePrivateValueFromP(parameter.p),
        parameter: parameter,
      );

  @override
  @protected
  DhPublicKey generatePublicKey(BigInt privateValue) => DhPublicKey(
        parameter.g.modPow(
          privateValue,
          parameter.p,
        ),
        parameter: parameter,
      );

  Map<String, dynamic> toJson({required String userId}) {
    return {
      'parameter': parameter.toJson(),
      'keyPair': _keyPair?.toJson(userId: userId),
      'secretKey': _secretKey?.toString()
    };
  }

  factory DhPkcs3Engine.fromJson(Map<String, dynamic> json) {
    return DhPkcs3Engine._(
      parameter: DhParameter.fromJson(json['parameter']),
      keyPair: json['keyPair'] != null ? DhKeyPair.fromJson(json['keyPair']) : null,
    ).._secretKey = json['secretKey'] != null ? BigInt.parse(json['secretKey']) : null;
  }
}

import 'package:diffie_hellman/diffie_hellman.dart';
import 'package:diffie_hellman/src/keys/codec/dh_private_key_codec.dart';
import 'package:diffie_hellman/src/keys/dh_key.dart';

class DhPrivateKey extends DhKey {
  DhPrivateKey(
    super.value, {
    required super.parameter,
  }) : super(
          codec: DhPrivateKeyCodec(),
        );

  factory DhPrivateKey.fromPem(String pem) => DhKey.fromPem(
        pem,
        codec: DhPrivateKeyCodec(),
      ) as DhPrivateKey;

  Map<String, dynamic> toJson() => {
        'value': value.toString(),
        'parameter': parameter.toJson(),
      };

  factory DhPrivateKey.fromJson(Map<String, dynamic> json) {
    return DhPrivateKey(
      BigInt.parse(json['value']),
      parameter: DhParameter.fromJson(json['parameter'] as Map<String, dynamic>),
    );
  }
}

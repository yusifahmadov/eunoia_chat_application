import 'package:diffie_hellman/diffie_hellman.dart';
import 'package:diffie_hellman/src/keys/codec/dh_public_key_codec.dart';
import 'package:diffie_hellman/src/keys/dh_key.dart';

class DhPublicKey extends DhKey {
  DhPublicKey(
    super.value, {
    required super.parameter,
  }) : super(
          codec: DhPublicKeyCodec(),
        );

  factory DhPublicKey.fromPem(String pem) => DhKey.fromPem(
        pem,
        codec: DhPublicKeyCodec(),
      ) as DhPublicKey;

  toJson() => {
        'value': value.toString(),
        'parameter': parameter.toJson(),
      };

  factory DhPublicKey.fromJson(Map<String, dynamic> json) {
    return DhPublicKey(
      BigInt.parse(json['value']),
      parameter: DhParameter.fromJson(json['parameter']),
    );
  }
}

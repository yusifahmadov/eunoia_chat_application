import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:eunoia_chat_application/core/encryption/dh_base.dart';
import 'package:pointycastle/pointycastle.dart';

class DiffieHellmanEncryption {
  List<BigInt> initiateKeyExchange() {
    DhGroup userA = DhGroup.byGroupId(1);
    DhGroup userB = DhGroup.byGroupId(1);

    DhKey userAKey = userA.generateKey();
    DhKey userBKey = userB.generateKey();

    BigInt userASharedSecret = userAKey.computeKey(userBKey);
    BigInt userBSharedSecret = userBKey.computeKey(userAKey);

    assert(userASharedSecret == userBSharedSecret, "Shared secrets should match.");
    return [userASharedSecret, userBSharedSecret];
  }

  Uint8List deriveEncryptionKey(BigInt sharedSecret) {
    var sharedSecretBytes = utf8.encode(sharedSecret.toString());
    var hash = sha256.convert(sharedSecretBytes);
    return Uint8List.fromList(hash.bytes);
  }

  Uint8List encryptMessage(Uint8List key, String message) {
    final encrypter = PaddedBlockCipher("AES/ECB/PKCS7");
    final params = PaddedBlockCipherParameters(KeyParameter(key), null);
    encrypter.init(true, params);

    return encrypter.process(Uint8List.fromList(utf8.encode(message)));
  }

  String decryptMessage(Uint8List key, Uint8List encryptedMessage) {
    final encrypter = PaddedBlockCipher("AES/ECB/PKCS7");
    final params = PaddedBlockCipherParameters(KeyParameter(key), null);
    encrypter.init(false, params);

    var decryptedBytes = encrypter.process(encryptedMessage);
    return utf8.decode(decryptedBytes);
  }

  void secureChatExample() {
    List<BigInt> keys = initiateKeyExchange();

    Uint8List encryptionKeyA = deriveEncryptionKey(keys[0]);
    Uint8List encryptionKeyB = deriveEncryptionKey(keys[1]);

    String message = "Hello, User B!";
    Uint8List encryptedMessage = encryptMessage(encryptionKeyA, message);

    String decryptedMessage = decryptMessage(encryptionKeyB, encryptedMessage);

    assert(message == decryptedMessage, "Decrypted message should match original.");

    print(encryptedMessage);
    print(decryptedMessage);
  }
}

import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:eunoia_chat_application/core/encryption/dh_base.dart';
import 'package:pointycastle/pointycastle.dart';

class DiffieHellmanEncryption {
  DhKey getPublicKey() {
    DhGroup userA = DhGroup.byGroupId(14);
    DhKey userAKey = userA.generateKey();
    return userAKey;
  }

  Uint8List convertStringToUint8List(String byteString) {
    // Split the comma-separated string into a list of strings
    List<int> byteStringList = jsonDecode(byteString).cast<int>();
    // Convert each string to an integer and create a list of integers
    List<int> byteList = byteStringList.map((s) => s).toList();
    // Convert the List of integers into a Uint8List
    return Uint8List.fromList(byteList);
  }

  BigInt generateSharedSecret(
      {required DhKey keyPair, required BigInt receiverPublicKey}) {
    // Define the Diffie-Hellman group (parameters), assuming group ID is 14

    // Your private key and the receiver's public key

    // Compute the shared secret using your private key and the receiver's public key
    BigInt sharedSecret = keyPair.computeSharedSecret(receiverPublicKey);

    return sharedSecret;
  }

  Uint8List encryptMessageRCase(
      {required DhKey keyPair,
      required BigInt receiverPublicKey,
      required String message}) {
    BigInt secretKey =
        generateSharedSecret(keyPair: keyPair, receiverPublicKey: receiverPublicKey);
    Uint8List encryptionKey = deriveEncryptionKey(secretKey); // 32-byte key
    return encryptMessage(encryptionKey, message); // Encrypt the message
  }

  String decryptMessageRCase({required BigInt secretKey, required String message}) {
    Uint8List encryptionKey = deriveEncryptionKey(secretKey); // 32-byte key
    Uint8List encryptedMessageBytes = convertStringToUint8List(message);

    return decryptMessage(encryptionKey, encryptedMessageBytes); // Decrypt the message
  }

  List<BigInt> initiateKeyExchange() {
    DhGroup userA = DhGroup.byGroupId(14);
    DhGroup userB = DhGroup.byGroupId(14);

    DhKey userAKey = userA.generateKey();
    DhKey userBKey = userB.generateKey();

    BigInt userASharedSecret = userAKey.computeSharedSecret(userBKey.publicKey);
    BigInt userBSharedSecret = userBKey.computeSharedSecret(userAKey.publicKey);
    assert(userASharedSecret == userBSharedSecret, "Shared secrets should match.");
    return [userASharedSecret, userBSharedSecret];
  }

  Uint8List deriveEncryptionKey(BigInt sharedSecret) {
    var sharedSecretBytes = utf8.encode(sharedSecret.toString());
    var hash = sha256.convert(sharedSecretBytes);
    var key = hash.bytes;

    print('Derived Key (Before Padding/Truncation): ${key.length} bytes');

    // Ensure key size is 32 bytes (256 bits)
    if (key.length < 32) {
      // Padding if the key is too small
      return Uint8List.fromList([...key, ...List.filled(32 - key.length, 0)]);
    } else if (key.length > 32) {
      // Truncate if key is too large
      return Uint8List.sublistView(Uint8List.fromList(key), 0, 32);
    }
    return Uint8List.fromList(key); // Return the 32-byte key
  }

  Uint8List encryptMessage(Uint8List key, String message) {
    final encrypter = PaddedBlockCipher("AES/ECB/PKCS7");
    final params = PaddedBlockCipherParameters(KeyParameter(key), null);
    encrypter.init(true, params);

    return encrypter.process(Uint8List.fromList(utf8.encode(message)));
  }

  String decryptMessage(Uint8List key, Uint8List encryptedMessage) {
    try {
      // Ensure the key length is exactly 32 bytes (AES-256 requirement)
      if (key.length != 32) {
        throw ArgumentError("Key must be 32 bytes for AES-256 decryption.");
      }

      final encrypter = PaddedBlockCipher("AES/ECB/PKCS7");
      final params = PaddedBlockCipherParameters(KeyParameter(key), null);
      encrypter.init(false, params);

      // Attempt to decrypt the message
      var decryptedBytes = encrypter.process(encryptedMessage);

      // Return the decoded message as a UTF-8 string
      return utf8.decode(decryptedBytes);
    } catch (e) {
      // Print debug information if an error occurs
      print("Decryption failed: ${e.toString()}");
      throw Exception("Decryption failed: ${e.toString()}");
    }
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

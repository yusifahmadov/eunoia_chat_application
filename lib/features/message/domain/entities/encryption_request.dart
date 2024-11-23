class EncryptionRequest {
  final int id;
  final String senderId;
  final String receiverId;
  final bool e2eeOffer;
  final bool status;
  final String? senderName;
  final String? receiverName;

  EncryptionRequest({
    required this.senderId,
    required this.receiverId,
    required this.e2eeOffer,
    required this.status,
    required this.id,
    required this.senderName,
    required this.receiverName,
  });
}

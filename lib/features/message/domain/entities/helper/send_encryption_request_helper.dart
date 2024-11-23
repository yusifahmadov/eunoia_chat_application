class SendEncryptionRequestHelper {
  final String senderId;
  final String receiverId;
  final bool e2eeOffer;
  final int conversationId;
  SendEncryptionRequestHelper(
      {required this.senderId,
      required this.receiverId,
      required this.e2eeOffer,
      required this.conversationId});

  Map<String, dynamic> toJson() {
    return {
      'p_sender_id': senderId,
      'p_receiver_id': receiverId,
      'p_e2ee_offer': e2eeOffer,
      'p_conversation_id': conversationId,
    };
  }

  fromJson(Map<String, dynamic> json) {
    return SendEncryptionRequestHelper(
      senderId: json['sender_id'] as String,
      conversationId: json['conversation_id'] as int,
      receiverId: json['receiver_id'] as String,
      e2eeOffer: json['e2ee_offer'] as bool,
    );
  }

  copyWith({String? senderId, String? receiverId, bool? e2eeOffer, int? conversationId}) {
    return SendEncryptionRequestHelper(
      senderId: senderId ?? this.senderId,
      conversationId: conversationId ?? this.conversationId,
      receiverId: receiverId ?? this.receiverId,
      e2eeOffer: e2eeOffer ?? this.e2eeOffer,
    );
  }
}

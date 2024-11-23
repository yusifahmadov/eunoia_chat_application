import 'package:eunoia_chat_application/features/message/domain/entities/encryption_request.dart';

class EncryptionRequestModel extends EncryptionRequest {
  EncryptionRequestModel(
      {required super.senderId,
      required super.receiverId,
      required super.e2eeOffer,
      required super.status,
      required super.receiverName,
      required super.senderName,
      required super.id});

  factory EncryptionRequestModel.fromJson(Map<String, dynamic> json) {
    return EncryptionRequestModel(
      id: json['id'] as int,
      senderId: json['sender_id'] as String,
      receiverId: json['receiver_id'] as String,
      e2eeOffer: json['e2ee_offer'] as bool,
      status: json['status'] as bool,
      receiverName:
          json['receiver_name'] != null ? json['receiver_name'] as String : null,
      senderName: json['sender_name'] != null ? json['sender_name'] as String : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'sender_id': super.senderId,
      'receiver_id': super.receiverId,
      'e2ee_offer': super.e2eeOffer,
      'status': super.status,
    };
  }
}

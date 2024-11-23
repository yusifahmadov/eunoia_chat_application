import '../../domain/entities/message.dart';

class MessageModel extends Message {
  const MessageModel(
      {required super.id,
      required super.message,
      required super.senderName,
      required super.createdAt,
      required super.conversationId,
      required super.encrypted,
      required super.senderId,
      required super.isRead});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as int,
      senderName: json['sender_name'] as String?,
      message: json['message_text'] as String,
      createdAt: DateTime.parse(json['created_at']),
      conversationId: json['conversation_id'] as int,
      senderId: json['sender_id'] as String,
      isRead: json['is_read'] as bool,
      encrypted: json['encrypted'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'message': super.message,
      'createdAt': super.createdAt.toIso8601String(),
      'conversationId': super.conversationId,
      'sender_id': super.senderId,
      'is_read': super.isRead,
      'sender_name': super.senderName,
    };
  }
}

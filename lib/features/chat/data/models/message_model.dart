import 'package:eunoia_chat_application/features/chat/domain/entities/message.dart';

class MessageModel extends Message {
  const MessageModel(
      {required super.id,
      required super.message,
      required super.fromNumber,
      required super.createdAt,
      required super.conversationId});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as int,
      message: json['message'] as String,
      fromNumber: json['from_number'] as String,
      createdAt: DateTime.parse(json['created_at']),
      conversationId: json['conversation_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'message': super.message,
      'fromNumber': super.fromNumber,
      'createdAt': super.createdAt.toIso8601String(),
      'conversationId': super.conversationId,
    };
  }
}

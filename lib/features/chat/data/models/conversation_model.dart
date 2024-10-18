import 'package:eunoia_chat_application/features/chat/data/models/message_model.dart';
import 'package:eunoia_chat_application/features/chat/domain/entities/conversation.dart';

class ConversationModel extends Conversation {
  const ConversationModel(
      {required super.id,
      required super.conversationName,
      required super.createdAt,
      required super.lastMessage});

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] as int,
      lastMessage: MessageModel.fromJson(json['last_message'] as Map<String, dynamic>),
      conversationName: json['conversation_name'] as String,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'conversation_name': super.conversationName,
      'created_at': super.createdAt.toIso8601String(),
      'last_message': (super.lastMessage).toJson(),
    };
  }
}

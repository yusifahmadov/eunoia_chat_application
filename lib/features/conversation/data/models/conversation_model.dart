import 'package:eunoia_chat_application/features/conversation/domain/entities/conversation.dart';
import 'package:eunoia_chat_application/features/message/data/models/message_model.dart';

class ConversationModel extends Conversation {
  const ConversationModel(
      {required super.id,
      required super.title,
      required super.senderProfilePhoto,
      required super.createdAt,
      required super.lastMessage});

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] as int,
      lastMessage: json['last_message'] != null
          ? MessageModel.fromJson(json['last_message'] as Map<String, dynamic>)
          : null,
      title: json['title'] as String,
      createdAt: DateTime.parse(json['created_at']),
      senderProfilePhoto: json['profile_photo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'title': super.title,
      'created_at': super.createdAt.toIso8601String(),
      'last_message': (super.lastMessage)?.toJson(),
      'profile_photo': super.senderProfilePhoto,
    };
  }
}

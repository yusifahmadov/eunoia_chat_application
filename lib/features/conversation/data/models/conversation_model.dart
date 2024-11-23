import '../../../message/data/models/message_model.dart';
import '../../domain/entities/conversation.dart';

class ConversationModel extends Conversation {
  const ConversationModel(
      {required super.id,
      required super.title,
      required super.senderProfilePhoto,
      required super.createdAt,
      required super.updatedAt,
      required super.creatorId,
      required super.lastMessage,
      required super.lastMessageOwnerPublicKey,
      required super.e2eeEnabled,
      required super.totalMessageCount});

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      e2eeEnabled: json['e2ee_enabled'] as bool,
      id: json['id'] as int,
      totalMessageCount: json['total_messages_count'] as int,
      updatedAt: DateTime.parse(json['updated_at']),
      creatorId: json['creator_id'] as String,
      lastMessage: json['last_message'] != null
          ? MessageModel.fromJson(json['last_message'] as Map<String, dynamic>)
          : null,
      title: json['title'] as String?,
      createdAt: DateTime.parse(json['created_at']),
      senderProfilePhoto: json['profile_photo'] as String?,
      lastMessageOwnerPublicKey: json['last_message_owner_public_key'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'title': super.title,
      'created_at': super.createdAt.toIso8601String(),
      'last_message': (super.lastMessage)?.toJson(),
      'profile_photo': super.senderProfilePhoto,
      'creator_id': super.creatorId,
      'total_messages_count': super.totalMessageCount,
      'updated_at': super.updatedAt.toIso8601String(),
    };
  }
}

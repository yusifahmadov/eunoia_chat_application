import '../../../message/data/models/message_model.dart';
import '../../domain/entities/conversation.dart';

class ConversationModel extends Conversation {
  const ConversationModel(
      {required super.id,
      required super.title,
      required super.otherPartyProfilePhoto,
      required super.createdAt,
      required super.updatedAt,
      required super.isGroup,
      required super.creatorId,
      required super.lastMessage,
      required super.lastMessageOwnerPublicKey,
      required super.groupPhoto,
      required super.totalMessageCount});

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] as int,
      groupPhoto: json['group_photo'] as String?,
      isGroup: json['is_group'] as bool,
      totalMessageCount: json['total_messages_count'] as int,
      updatedAt: DateTime.parse(json['updated_at']),
      creatorId: json['creator_id'] as String,
      lastMessage: json['last_message'] != null
          ? MessageModel.fromJson(json['last_message'] as Map<String, dynamic>)
          : null,
      title: json['title'] as String?,
      createdAt: DateTime.parse(json['created_at']),
      otherPartyProfilePhoto: json['receiver_profile_photo'] as String?,
      lastMessageOwnerPublicKey: json['last_message_owner_public_key'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'title': super.title,
      'created_at': super.createdAt.toIso8601String(),
      'last_message': (super.lastMessage)?.toJson(),
      'profile_photo': super.otherPartyProfilePhoto,
      'creator_id': super.creatorId,
      'is_group': super.isGroup,
      'total_messages_count': super.totalMessageCount,
      'updated_at': super.updatedAt.toIso8601String(),
    };
  }
}

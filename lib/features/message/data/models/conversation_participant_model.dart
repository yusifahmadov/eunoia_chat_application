import 'package:eunoia_chat_application/features/message/domain/entities/conversation_participant.dart';

class ConversationParticipantModel extends ConversationParticipant {
  ConversationParticipantModel(
      {required super.id,
      required super.name,
      required super.isAdmin,
      required super.username,
      required super.createdAt,
      required super.photo});

  factory ConversationParticipantModel.fromJson(Map<String, dynamic> json) {
    return ConversationParticipantModel(
      id: json['participant_id'] as String,
      name: json['participant_name'] as String,
      photo: json['participant_photo'] as String?,
      isAdmin: json['is_admin'] as bool,
      username: json['participant_username'] as String,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  toJson() {
    return {
      'id': super.id,
      'name': super.name,
      'is_admin': super.isAdmin,
      'created_at': super.createdAt.toIso8601String(),
    };
  }
}

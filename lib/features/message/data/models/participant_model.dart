import '../../domain/entities/participant.dart';
import '../../domain/entities/participant_type.dart';

class ParticipantModel extends Participant {
  const ParticipantModel(
      {required super.id,
      required super.joinedAt,
      required super.readMessageCount,
      required super.conversationId,
      required super.userId,
      required super.type});

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return ParticipantModel(
      id: json['id'] as int,
      readMessageCount: json['read_message_count'] as int,
      joinedAt: DateTime.parse(json['joined_at']),
      conversationId: json['conversation_id'] as int,
      userId: json['user_id'] as int,
      type: json['type'] as ParticipantType,
    );
  }

  toJson() {
    return {
      'id': super.id,
      'joined_at': super.joinedAt.toIso8601String(),
      'conversation_id': super.conversationId,
      'user_id': super.userId,
      'type': super.type,
      'read_message_count': super.readMessageCount,
    };
  }
}

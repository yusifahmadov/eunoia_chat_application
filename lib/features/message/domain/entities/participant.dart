import 'package:equatable/equatable.dart';

import 'participant_type.dart';

class Participant extends Equatable {
  final int id;
  final int conversationId;
  final int userId;
  final ParticipantType type;
  final DateTime joinedAt;
  final DateTime? leftAt;
  final int readMessageCount;

  const Participant({
    required this.id,
    required this.readMessageCount,
    required this.conversationId,
    required this.userId,
    required this.type,
    required this.joinedAt,
    this.leftAt,
  });

  @override
  List<Object?> get props => [id, conversationId, userId, type, joinedAt, leftAt];
}

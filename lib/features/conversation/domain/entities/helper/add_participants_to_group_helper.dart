import 'package:eunoia_chat_application/features/message/domain/entities/conversation_participant.dart';

class AddParticipantsToGroupHelper {
  final int groupId;
  final List<ConversationParticipant> participants;

  AddParticipantsToGroupHelper({required this.groupId, required this.participants});

  toJson() {
    return {
      'p_conversation_id': groupId,
      'p_user_ids': participants.map((e) => e.id).toList(),
    };
  }

  copyWith({int? groupId, List<ConversationParticipant>? participants}) {
    return AddParticipantsToGroupHelper(
      groupId: groupId ?? this.groupId,
      participants: participants ?? this.participants,
    );
  }
}

import 'package:eunoia_chat_application/features/message/domain/entities/conversation_participant.dart';

class GroupData {
  final int id;
  final String title;
  final String? photo;
  final String creatorId;
  final List<ConversationParticipant> participants;
  GroupData(
      {required this.id,
      required this.title,
      required this.participants,
      required this.photo,
      required this.creatorId});
}

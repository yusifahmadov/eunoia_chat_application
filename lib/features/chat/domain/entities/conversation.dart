import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/features/chat/data/models/message_model.dart';

class Conversation extends Equatable {
  final int id;
  final String conversationName;
  final DateTime createdAt;
  final MessageModel lastMessage;

  const Conversation({
    required this.id,
    required this.conversationName,
    required this.createdAt,
    required this.lastMessage,
  });

  @override
  List<Object?> get props => [id, conversationName, createdAt, lastMessage];
}

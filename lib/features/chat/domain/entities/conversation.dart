import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/features/chat/data/models/message_model.dart';

class Conversation extends Equatable {
  final int id;
  final String title;
  final DateTime createdAt;
  final MessageModel? lastMessage;
  final String? senderProfilePhoto;
  const Conversation({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.lastMessage,
    this.senderProfilePhoto,
  });

  @override
  List<Object?> get props => [id, title, createdAt, lastMessage];

  copyWith({
    int? id,
    String? title,
    DateTime? createdAt,
    MessageModel? lastMessage,
    String? senderProfilePhoto,
  }) {
    return Conversation(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      lastMessage: lastMessage ?? this.lastMessage,
      senderProfilePhoto: senderProfilePhoto ?? this.senderProfilePhoto,
    );
  }
}

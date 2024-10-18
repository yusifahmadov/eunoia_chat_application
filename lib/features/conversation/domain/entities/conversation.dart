import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/features/message/data/models/message_model.dart';

class Conversation extends Equatable {
  final int id;
  final String title;
  final DateTime createdAt;
  final MessageModel? lastMessage;
  final String? senderProfilePhoto;
  final String? creatorId;
  final DateTime updatedAt;
  const Conversation({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.lastMessage,
    required this.updatedAt,
    this.creatorId,
    this.senderProfilePhoto,
  });

  @override
  List<Object?> get props =>
      [id, title, createdAt, lastMessage, senderProfilePhoto, creatorId];

  copyWith({
    int? id,
    String? title,
    DateTime? createdAt,
    MessageModel? lastMessage,
    String? senderProfilePhoto,
    String? creatorId,
    DateTime? updatedAt,
  }) {
    return Conversation(
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      lastMessage: lastMessage ?? this.lastMessage,
      senderProfilePhoto: senderProfilePhoto ?? this.senderProfilePhoto,
    );
  }
}

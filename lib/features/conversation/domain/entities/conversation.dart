import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/features/conversation/data/models/conversation_model.dart';

import '../../../message/data/models/message_model.dart';

class Conversation extends Equatable {
  final int id;
  final String? title;
  final DateTime createdAt;
  final MessageModel? lastMessage;
  final String? senderProfilePhoto;
  final String? creatorId;
  final DateTime updatedAt;
  final int totalMessageCount;
  final String? lastMessageOwnerPublicKey;

  final bool e2eeEnabled;
  const Conversation(
      {required this.id,
      required this.title,
      required this.createdAt,
      required this.lastMessage,
      required this.updatedAt,
      required this.totalMessageCount,
      this.creatorId,
      this.senderProfilePhoto,
      this.lastMessageOwnerPublicKey,
      required this.e2eeEnabled});

  @override
  List<Object?> get props =>
      [id, title, createdAt, lastMessage, senderProfilePhoto, creatorId];

  ConversationModel copyWith({
    int? id,
    String? title,
    DateTime? createdAt,
    MessageModel? lastMessage,
    String? senderProfilePhoto,
    String? creatorId,
    DateTime? updatedAt,
    int? totalMessageCount,
    String? lastMessageOwnerPublicKey,
    bool? e2eeEnabled,
  }) {
    return ConversationModel(
      lastMessageOwnerPublicKey:
          lastMessageOwnerPublicKey ?? this.lastMessageOwnerPublicKey,
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      totalMessageCount: totalMessageCount ?? this.totalMessageCount,
      createdAt: createdAt ?? this.createdAt,
      lastMessage: lastMessage ?? this.lastMessage,
      senderProfilePhoto: senderProfilePhoto ?? this.senderProfilePhoto,
      e2eeEnabled: e2eeEnabled ?? this.e2eeEnabled,
    );
  }
}

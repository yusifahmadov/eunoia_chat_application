import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/features/conversation/data/models/conversation_model.dart';

import '../../../message/data/models/message_model.dart';

class Conversation extends Equatable {
  final int id;
  final String? title;
  final DateTime createdAt;
  final MessageModel? lastMessage;
  final String? otherPartyProfilePhoto;
  final String? creatorId;
  final DateTime updatedAt;
  final int totalMessageCount;
  final String? lastMessageOwnerPublicKey;
  final bool isGroup;
  final String? groupPhoto;

  const Conversation({
    required this.id,
    required this.title,
    required this.isGroup,
    required this.createdAt,
    required this.lastMessage,
    required this.updatedAt,
    required this.groupPhoto,
    required this.totalMessageCount,
    this.creatorId,
    this.otherPartyProfilePhoto,
    this.lastMessageOwnerPublicKey,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        createdAt,
        lastMessage,
        otherPartyProfilePhoto,
        creatorId,
        updatedAt,
        totalMessageCount,
        lastMessageOwnerPublicKey,
        isGroup,
        groupPhoto,
      ];

  ConversationModel copyWith(
      {int? id,
      String? title,
      DateTime? createdAt,
      MessageModel? lastMessage,
      String? otherPartyProfilePhoto,
      String? creatorId,
      DateTime? updatedAt,
      int? totalMessageCount,
      String? lastMessageOwnerPublicKey,
      String? groupPhoto,
      bool? isGroup}) {
    return ConversationModel(
      isGroup: isGroup ?? this.isGroup,
      lastMessageOwnerPublicKey:
          lastMessageOwnerPublicKey ?? this.lastMessageOwnerPublicKey,
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      groupPhoto: groupPhoto ?? this.groupPhoto,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      totalMessageCount: totalMessageCount ?? this.totalMessageCount,
      createdAt: createdAt ?? this.createdAt,
      lastMessage: lastMessage ?? this.lastMessage,
      otherPartyProfilePhoto: otherPartyProfilePhoto ?? this.otherPartyProfilePhoto,
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/features/message/data/models/message_model.dart';

class Message extends Equatable {
  final int id;
  final String message;

  final DateTime createdAt;
  final int conversationId;
  final String senderId;
  final String? senderName;
  final bool isRead;
  final bool encrypted;
  const Message({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    required this.isRead,
    required this.encrypted,
  });
  @override
  List<Object?> get props => [id, message, createdAt, conversationId];

  MessageModel copyWith(
      {int? id,
      String? message,
      DateTime? createdAt,
      int? conversationId,
      String? senderId,
      String? senderName,
      bool? isRead,
      bool? e2eeEnabled}) {
    return MessageModel(
      id: id ?? this.id,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      isRead: isRead ?? this.isRead,
      encrypted: e2eeEnabled ?? encrypted,
    );
  }
}

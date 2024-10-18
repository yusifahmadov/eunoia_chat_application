import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final int id;
  final String message;

  final DateTime createdAt;
  final int conversationId;
  final String senderId;
  final String? senderName;
  final bool isRead;
  const Message({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    required this.isRead,
  });
  @override
  List<Object?> get props => [id, message, createdAt, conversationId];
}

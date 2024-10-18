import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final int id;
  final String message;
  final String fromNumber;
  final DateTime createdAt;
  final int conversationId;

  const Message({
    required this.id,
    required this.message,
    required this.fromNumber,
    required this.createdAt,
    required this.conversationId,
  });
  @override
  List<Object?> get props => [id, message, fromNumber, createdAt, conversationId];
}

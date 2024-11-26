import 'package:equatable/equatable.dart';

class ConversationParticipant extends Equatable {
  final String id;
  final String name;
  final bool isAdmin;
  final DateTime createdAt;
  final String? photo;
  final String username;
  const ConversationParticipant({
    required this.id,
    required this.username,
    required this.photo,
    required this.name,
    required this.isAdmin,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, isAdmin, createdAt, photo, username];
}

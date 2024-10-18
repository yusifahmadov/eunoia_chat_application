import 'package:equatable/equatable.dart';

class GroupMember extends Equatable {
  final int id;
  final int contactId;
  final DateTime joinedAt;
  final DateTime? leftAt;

  const GroupMember({
    required this.id,
    required this.contactId,
    required this.joinedAt,
    this.leftAt,
  });

  @override
  List<Object?> get props => [id, contactId, joinedAt, leftAt];
}

import 'package:eunoia_chat_application/features/chat/domain/entities/group_member.dart';

class GroupMemberModel extends GroupMember {
  const GroupMemberModel(
      {required super.id, required super.contactId, required super.joinedAt});

  factory GroupMemberModel.fromJson(Map<String, dynamic> json) {
    return GroupMemberModel(
      id: json['id'] as int,
      contactId: json['contact_id'] as int,
      joinedAt: DateTime.parse(json['joined_at']),
    );
  }

  toJson() {
    return {
      'id': super.id,
      'contact_id': super.contactId,
      'joined_at': super.joinedAt.toIso8601String(),
    };
  }
}

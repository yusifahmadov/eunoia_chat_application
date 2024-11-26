import 'package:eunoia_chat_application/features/conversation/domain/entities/group_data.dart';
import 'package:eunoia_chat_application/features/message/data/models/conversation_participant_model.dart';

class GroupDataModel extends GroupData {
  GroupDataModel({
    required super.id,
    required super.title,
    required super.participants,
    required super.photo,
    required super.creatorId,
  });

  factory GroupDataModel.fromJson(Map<String, dynamic> json) {
    return GroupDataModel(
      id: json['group_id'],
      title: json['group_title'],
      creatorId: json['creator_id'],
      photo: json['group_photo'] as String?,
      participants: (json['participants'] as List)
          .map((e) => ConversationParticipantModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'title': super.title,
      'photo': super.photo,
      'creator_id': super.creatorId,
    };
  }
}

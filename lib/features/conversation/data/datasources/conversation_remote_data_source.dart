import 'package:eunoia_chat_application/core/response/response_model.dart';
import 'package:eunoia_chat_application/features/conversation/data/models/group_data_model.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/add_group_photo_helper.dart';

import '../../domain/entities/helper/get_conversations_helper.dart';
import '../models/conversation_model.dart';

abstract class ConversationRemoteDataSource {
  Future<List<ConversationModel>> getConversations(
      {required GetConversationsHelper body});
  Future<ConversationModel?> listenConversations(
      {required void Function({required ConversationModel conversation}) callBackFunc});

  Future<int> makeGroupConversation({required Map<String, dynamic> body});
  Future<void> addParticipantsToGroupConversation({required Map<String, dynamic> body});
  Future<List<GroupDataModel>> getGroupData(int conversationId);
  Future<void> addGroupPhoto({required AddGroupPhotoHelper body});
  Future<ResponseModel> leaveGroup(int conversationId);
}

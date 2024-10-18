import 'package:eunoia_chat_application/features/conversation/data/models/conversation_model.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/get_conversations_helper.dart';

abstract class ConversationRemoteDataSource {
  Future<List<ConversationModel>> getConversations(
      {required GetConversationsHelper body});
  Future<ConversationModel?> listenConversations(
      {required void Function({required ConversationModel conversation}) callBackFunc});
}

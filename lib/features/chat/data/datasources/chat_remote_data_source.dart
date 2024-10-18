import 'package:eunoia_chat_application/features/chat/data/models/conversation_model.dart';
import 'package:eunoia_chat_application/features/chat/domain/entities/helper/get_conversations_helper.dart';

abstract class ChatRemoteDataSource {
  Future<List<ConversationModel>> getConversations(
      {required GetConversationsHelper body});
  Future<ConversationModel?> listenConversations(
      {required void Function({required ConversationModel conversation}) callBackFunc});
}

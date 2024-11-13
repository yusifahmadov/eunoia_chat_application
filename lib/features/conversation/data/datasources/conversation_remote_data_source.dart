import '../../domain/entities/helper/get_conversations_helper.dart';
import '../models/conversation_model.dart';

abstract class ConversationRemoteDataSource {
  Future<List<ConversationModel>> getConversations(
      {required GetConversationsHelper body});
  Future<ConversationModel?> listenConversations(
      {required void Function({required ConversationModel conversation}) callBackFunc});
}

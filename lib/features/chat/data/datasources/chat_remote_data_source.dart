import 'package:eunoia_chat_application/features/chat/data/models/conversation_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ConversationModel>> getConversations({required String userId});
}

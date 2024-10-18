import 'package:dio/dio.dart';
import 'package:eunoia_chat_application/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:eunoia_chat_application/features/chat/data/models/conversation_model.dart';
import 'package:eunoia_chat_application/injection.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  @override
  Future<List<ConversationModel>> getConversations({required String userId}) async {
    final response = await getIt<Dio>().get('/get_user_conversations?userId=$userId');
    return (response.data as List)
        .map((e) => ConversationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

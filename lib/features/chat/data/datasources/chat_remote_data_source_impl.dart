import 'package:dio/dio.dart';
import 'package:eunoia_chat_application/core/supabase/supabase_repository.dart';
import 'package:eunoia_chat_application/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:eunoia_chat_application/features/chat/data/models/conversation_model.dart';
import 'package:eunoia_chat_application/features/chat/domain/entities/helper/get_conversations_helper.dart';
import 'package:eunoia_chat_application/injection.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  @override
  Future<List<ConversationModel>> getConversations(
      {required GetConversationsHelper body}) async {
    final response = await getIt<Dio>().get(
      '/rest/v1/rpc/get_user_conversations?user_id=${body.userId}&limit_count=${body.limit}&offset_count=${body.offset}&search_name=${body.fullName}}',
    );

    print(body.toString());
    return (response.data as List)
        .map((e) => ConversationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ConversationModel?> listenConversations(
      {required void Function({required ConversationModel conversation})
          callBackFunc}) async {
    return await SupabaseRepository.listenConversations(callBackFunc: callBackFunc);
  }
}

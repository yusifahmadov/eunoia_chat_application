import 'package:dio/dio.dart';

import '../../../../core/supabase/supabase_repository.dart';
import '../../../../injection.dart';
import '../../domain/entities/helper/get_conversations_helper.dart';
import '../models/conversation_model.dart';
import 'conversation_remote_data_source.dart';

class ConversationRemoteDataSourceImpl implements ConversationRemoteDataSource {
  @override
  Future<List<ConversationModel>> getConversations(
      {required GetConversationsHelper body}) async {
    final response = await getIt<Dio>().get(
      '/rest/v1/rpc/get_user_conversations?user_id=${body.userId}&limit_count=${body.limit}&offset_count=${body.offset}&search_name=${body.fullName}}',
    );

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

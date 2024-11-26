import 'package:dio/dio.dart';

import '../../../../core/supabase/supabase_repository.dart';
import '../../../../injection.dart';
import '../../domain/entities/helper/get_message_helper.dart';
import '../../domain/entities/helper/listen_message_helper.dart';
import '../../domain/entities/helper/read_messages_helper.dart';
import '../../domain/entities/helper/send_message_helper.dart';
import '../models/message_model.dart';
import 'message_remote_data_source.dart';

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  @override
  Future<List<MessageModel>> getMessages({required GetMessageHelper body}) async {
    final response = await getIt<Dio>().get(
      '/rest/v1/rpc/get_messages_by_conversation?p_conversation_id=${body.conversationId}&limit_count=${body.limit}&offset_count=${body.offset}',
    );

    return (response.data as List).map((e) => MessageModel.fromJson(e)).toList();
  }

  @override
  Future<void> sendMessage({required SendMessageHelper body}) {
    final response = getIt<Dio>().post(
      '/rest/v1/rpc/send_message',
      data: body.toJson(),
    );

    return response.then((value) => null);
  }

  @override
  Future<MessageModel?> listenMessages({required ListenMessageHelper body}) async {
    return await SupabaseRepository.listenMessages(
        callBackFunc: body.callBackFunc, conversationId: body.conversationId);
  }

  @override
  Future<void> readMessages({required ReadMessagesHelper body}) {
    final response = getIt<Dio>().post(
      '/rest/v1/rpc/mark_messages_as_read',
      data: body.toJson(),
    );

    return response.then((value) => null);
  }

  @override
  Future<void> readMessagesByConversation({required ReadMessagesHelper body}) {
    final response = getIt<Dio>().post(
      '/rest/v1/rpc/mark_messages_as_read_by_conversation',
      data: body.toJsonForReadAll(),
    );

    return response.then((value) => null);
  }

  @override
  Future<void> sendGroupMessage({required Map<String, dynamic> body}) async {
    final response = getIt<Dio>().post(
      '/rest/v1/rpc/send_group_message',
      data: body,
    );

    return response.then((value) => null);
  }
}

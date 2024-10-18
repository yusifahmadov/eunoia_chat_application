import 'package:dio/dio.dart';
import 'package:eunoia_chat_application/core/supabase/supabase_repository.dart';
import 'package:eunoia_chat_application/features/message/data/datasources/message_remote_data_source.dart';
import 'package:eunoia_chat_application/features/message/data/models/message_model.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/get_message_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/listen_message_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/send_message_helper.dart';
import 'package:eunoia_chat_application/injection.dart';

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
}

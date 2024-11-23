import 'package:dio/dio.dart';
import 'package:eunoia_chat_application/core/response/response_model.dart';
import 'package:eunoia_chat_application/features/message/data/models/encryption_request_model.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/encryption_request.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/handle_encryption_request_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/listen_encryption_requests_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/send_encryption_request_helper.dart';

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
  Future<ResponseModel> sendEncryptionRequest(
      {required SendEncryptionRequestHelper body}) async {
    final response = await getIt<Dio>().post(
      '/rest/v1/rpc/add_encryption_request',
      data: body.toJson(),
    );

    return ResponseModel.fromJson(response.data);
  }

  @override
  Future<List<EncryptionRequest>> getEncryptionRequest(
      {required int conversationId}) async {
    final response = await getIt<Dio>().post(
      '/rest/v1/rpc/get_last_encryption_request',
      data: {
        "p_conversation_id": conversationId,
      },
    );

    return (response.data as List)
        .map((e) => EncryptionRequestModel.fromJson(e))
        .toList();
  }

  @override
  Future<ResponseModel> handleEncryptionRequest(
      {required HandleEncryptionRequestHelper body}) async {
    final response = await getIt<Dio>()
        .post('/rest/v1/rpc/handle_encryption_request', data: body.toJson());

    return ResponseModel.fromJson(response.data);
  }

  @override
  Future<EncryptionRequestModel?> listenEncryptionRequests(
      {required ListenEncryptionRequestsHelper body}) async {
    return await SupabaseRepository.listenEncryptionRequests(
        answer: body.answer,
        callBackFunc: body.callBackFunc,
        conversationId: body.conversationId);
  }
}

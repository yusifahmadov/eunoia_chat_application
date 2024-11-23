import 'package:eunoia_chat_application/core/response/response_model.dart';
import 'package:eunoia_chat_application/features/message/data/models/encryption_request_model.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/encryption_request.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/handle_encryption_request_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/listen_encryption_requests_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/send_encryption_request_helper.dart';

import '../../domain/entities/helper/get_message_helper.dart';
import '../../domain/entities/helper/listen_message_helper.dart';
import '../../domain/entities/helper/read_messages_helper.dart';
import '../../domain/entities/helper/send_message_helper.dart';
import '../models/message_model.dart';

abstract class MessageRemoteDataSource {
  Future<List<MessageModel>> getMessages({required GetMessageHelper body});
  Future<void> sendMessage({required SendMessageHelper body});
  Future<MessageModel?> listenMessages({required ListenMessageHelper body});
  Future<void> readMessages({required ReadMessagesHelper body});
  Future<void> readMessagesByConversation({required ReadMessagesHelper body});
  Future<ResponseModel> sendEncryptionRequest(
      {required SendEncryptionRequestHelper body});

  Future<List<EncryptionRequest>> getEncryptionRequest({required int conversationId});

  Future<ResponseModel> handleEncryptionRequest(
      {required HandleEncryptionRequestHelper body});

  Future<EncryptionRequestModel?> listenEncryptionRequests(
      {required ListenEncryptionRequestsHelper body});
}

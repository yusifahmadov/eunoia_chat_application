import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/encryption_request.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/handle_encryption_request_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/listen_encryption_requests_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/send_encryption_request_helper.dart';

import '../../../../core/response/response.dart';
import '../entities/helper/get_message_helper.dart';
import '../entities/helper/listen_message_helper.dart';
import '../entities/helper/read_messages_helper.dart';
import '../entities/helper/send_message_helper.dart';
import '../entities/message.dart';

abstract class MessageRepository {
  Future<Either<ResponseI, List<Message>>> getMessages({required GetMessageHelper body});
  Future<Either<ResponseI, void>> sendMessage({required SendMessageHelper body});
  Future<Either<ResponseI, Message?>> listenMessages({required ListenMessageHelper body});
  Future<Either<ResponseI, void>> readMessages({required ReadMessagesHelper body});
  Future<Either<ResponseI, void>> readMessagesByConversation(
      {required ReadMessagesHelper body});

  Future<Either<ResponseI, ResponseI>> sendEncryptionRequest(
      SendEncryptionRequestHelper body);

  Future<Either<ResponseI, List<EncryptionRequest>>> getLastEncryption(
      int conversationId);

  Future<Either<ResponseI, ResponseI>> handleEncryptionRequest(
      {required HandleEncryptionRequestHelper body});

  Future<Either<ResponseI, EncryptionRequest?>> listenEncryptionRequests(
      ListenEncryptionRequestsHelper body);
}

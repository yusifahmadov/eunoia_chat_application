import 'package:dartz/dartz.dart';

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
}

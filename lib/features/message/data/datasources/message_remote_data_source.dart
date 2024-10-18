import 'package:eunoia_chat_application/features/message/data/models/message_model.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/get_message_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/listen_message_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/send_message_helper.dart';

abstract class MessageRemoteDataSource {
  Future<List<MessageModel>> getMessages({required GetMessageHelper body});
  Future<void> sendMessage({required SendMessageHelper body});
  Future<MessageModel?> listenMessages({required ListenMessageHelper body});
}

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
}

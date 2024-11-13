import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/conversation/data/models/conversation_model.dart';
import '../../features/message/data/models/message_model.dart';
import '../../features/message/domain/entities/message.dart';

abstract class SupabaseRepository {
  static late final RealtimeClient socket;
  static final supabase = Supabase.instance.client;
  static Future<ConversationModel?> listenConversations({
    required void Function({required ConversationModel conversation}) callBackFunc,
  }) async {
    ConversationModel? conversationModel;

    supabase
        .channel('conversation')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          callback: (payload) async {
            conversationModel = ConversationModel.fromJson(payload.newRecord);

            if (conversationModel != null) {
              callBackFunc(conversation: conversationModel!);
            }
          },
          schema: 'public',
          table: 'conversation',
        )
        .subscribe();
    return conversationModel;
  }

  static Future<MessageModel?> listenMessages(
      {required void Function({required Message message}) callBackFunc,
      required int conversationId}) async {
    MessageModel? messageModel;

    supabase
        .channel('${conversationId}_messages')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          callback: (payload) {
            messageModel = MessageModel.fromJson(payload.newRecord);
            if (messageModel != null) {
              callBackFunc(message: messageModel!);
            }
          },
          schema: 'public',
          table: 'messages',
        )
        .subscribe();

    return messageModel;
  }

  static leaveMessageChannel({required int conversationId}) async {
    await supabase.channel('${conversationId}_messages').unsubscribe();
  }

  static closeSocket() async {
    for (var i = 0; i < socket.getChannels().length; i++) {
      await socket.getChannels()[i].unsubscribe();
    }

    socket.disconnect();
  }
}

import 'package:eunoia_chat_application/core/shared_preferences/shared_preferences_user_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/conversation/data/models/conversation_model.dart';
import '../../features/message/data/models/message_model.dart';
import '../../features/message/domain/entities/message.dart';

abstract class SupabaseRepository {
  static late final RealtimeClient socket;
  static final supabase = Supabase.instance.client;

  static Future<ConversationModel?> listenConversationsAdvanced({
    required void Function({required ConversationModel conversation}) callBackFunc,
  }) async {
    final String? userId = (await SharedPreferencesUserManager.getUser())?.user.id;
    if (userId == null) {
      return null;
    }
    ConversationModel? conversationModel;

    supabase
        .from('events')
        .stream(primaryKey: ['id'])
        .eq('topic', 'conversation_$userId')
        .order('created_at', ascending: false)
        .limit(1)
        .listen((event) {
          if (event.isEmpty) return;

          conversationModel = ConversationModel.fromJson(event.first['data']);

          if (conversationModel != null) {
            callBackFunc(conversation: conversationModel!);
          }
        });
    return conversationModel;
  }

  static Future<MessageModel?> listenMessagesAdvanced(
      {required void Function({required Message message}) callBackFunc,
      required int conversationId}) async {
    MessageModel? messageModel;
    supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('conversation_id', conversationId)
        .order('created_at', ascending: false)
        .limit(1)
        .listen((event) {
          if (event.isEmpty) return;
          messageModel = MessageModel.fromJson(event.first);

          if (messageModel != null) {
            callBackFunc(message: messageModel!);
          }
        });
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

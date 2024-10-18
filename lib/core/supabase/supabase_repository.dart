import 'package:eunoia_chat_application/features/conversation/data/models/conversation_model.dart';
import 'package:eunoia_chat_application/features/message/data/models/message_model.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/message.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseRepository {
  static late final RealtimeClient socket;
  static final supabase = Supabase.instance.client;
  static Future<ConversationModel?> listenConversations(
      {required void Function({required ConversationModel conversation})
          callBackFunc}) async {
    ConversationModel? conversationModel;

    supabase
        .channel('conversation')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          callback: (payload) {
            conversationModel = ConversationModel.fromJson(payload.newRecord);
            if (conversationModel != null) {
              print(payload.newRecord);
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
        .channel('messages')
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

  leaveMessageChannel() async {
    for (var i = 0; i < socket.getChannels().length; i++) {
      await socket.getChannels()[i].unsubscribe();
    }
  }

  // static Future<void> initSocket() async {
  //   socket = RealtimeClient(
  //     'wss://${dotenv.get('SUPABASE_API_REALTIME_ENDPOINT')}/realtime/v1',
  //     params: {'apikey': dotenv.get('SUPABASE_API_KEY')},
  //   );

  //   final AuthResponseModel user = AuthResponseModel.fromJson(
  //       await CustomSharedPreferences.readUser("user") as Map<String, dynamic>);
  //   socket.setAuth(user.accessToken);
  // }

  static closeSocket() async {
    for (var i = 0; i < socket.getChannels().length; i++) {
      await socket.getChannels()[i].unsubscribe();
    }

    socket.disconnect();
  }
}

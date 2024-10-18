import 'package:eunoia_chat_application/core/shared_preferences/shared_preferences_user_manager.dart';
import 'package:eunoia_chat_application/features/conversation/data/models/conversation_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:realtime_client/realtime_client.dart';

abstract class SupabaseRepository {
  static late final RealtimeClient socket;

  static Future<ConversationModel?> listenConversations(
      {required void Function({required ConversationModel conversation})
          callBackFunc}) async {
    final channel = socket.channel('realtime:public:chat');
    ConversationModel? conversationModel;
    print(((await SharedPreferencesUserManager.getUser())?.user.id));
    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          table: 'conversation',
          schema: 'public',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'creator_id',
            value: ((await SharedPreferencesUserManager.getUser())?.user.id),
          ),
          callback: (payload) {
            conversationModel = ConversationModel.fromJson(payload.newRecord);
            if (conversationModel != null) {
              callBackFunc(conversation: conversationModel!);
            }
          },
        )
        .subscribe();

    return conversationModel;
  }

  static Future<void> initSocket() async {
    socket = RealtimeClient(
      'wss://${dotenv.get('SUPABASE_API_REALTIME_ENDPOINT')}/realtime/v1',
      params: {'apikey': dotenv.get('SUPABASE_API_KEY')},
    );

    // final AuthResponseModel? user =
    //     AuthResponseModel.fromJson(await CustomSharedPreferences.readUser("user"));

    // socket.setAuth(user.accessToken);
  }

  static closeSocket() async {
    for (var i = 0; i < socket.getChannels().length; i++) {
      await socket.getChannels()[i].unsubscribe();
    }

    socket.disconnect();
  }
}

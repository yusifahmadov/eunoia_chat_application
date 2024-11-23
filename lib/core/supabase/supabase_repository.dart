import 'package:eunoia_chat_application/core/shared_preferences/shared_preferences_user_manager.dart';
import 'package:eunoia_chat_application/features/message/data/models/encryption_request_model.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/encryption_request.dart';
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

  static Future<EncryptionRequestModel?> listenEncryptionRequests(
      {required void Function({required EncryptionRequest request}) callBackFunc,
      required int conversationId,
      required bool? answer}) async {
    EncryptionRequestModel? encryptionRequestModel;
    supabase
        .channel('${conversationId}_encryption_requests')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          callback: (payload) async {
            encryptionRequestModel = EncryptionRequestModel.fromJson(payload.newRecord);
            if (encryptionRequestModel != null) {
              if ((encryptionRequestModel!.status == true) ||
                  encryptionRequestModel!.receiverId !=
                      (await SharedPreferencesUserManager.getUser())!.user.id) {
                return;
              }
              callBackFunc(request: encryptionRequestModel!);
            }
          },
          schema: 'public',
          table: 'encryption_requests',
        )
        .subscribe();

    return encryptionRequestModel;
  }

  static leaveMessageChannel({required int conversationId}) async {
    await supabase.channel('${conversationId}_messages').unsubscribe();
  }

  static leaveEncryptionRequestChannel({required int conversationId}) async {
    await supabase.channel('${conversationId}_encryption_requests').unsubscribe();
  }

  static closeSocket() async {
    for (var i = 0; i < socket.getChannels().length; i++) {
      await socket.getChannels()[i].unsubscribe();
    }

    socket.disconnect();
  }
}

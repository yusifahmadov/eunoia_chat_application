import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/core/encryption/diffie_hellman_encryption.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/send_group_message_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/usecases/send_group_message_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/flasher/custom_flasher.dart';
import '../../../../core/mixins/cubit_scrolling_mixin.dart';
import '../../../../core/shared_preferences/shared_preferences_user_manager.dart';
import '../../../../core/supabase/supabase_repository.dart';
import '../../domain/entities/helper/get_message_helper.dart';
import '../../domain/entities/helper/listen_message_helper.dart';
import '../../domain/entities/helper/read_messages_helper.dart';
import '../../domain/entities/helper/send_message_helper.dart';
import '../../domain/entities/message.dart';
import '../../domain/usecases/get_messages_usecase.dart';
import '../../domain/usecases/listen_messages_usecase.dart';
import '../../domain/usecases/read_messages_by_conversation_usecase.dart';
import '../../domain/usecases/read_messages_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState>
    with CubitScrollingMixin<Message, GetMessageHelper> {
  GetMessagesUsecase getMessagesUsecase;
  SendMessageUsecase sendMessageUsecase;
  ListenMessagesUsecase listenMessagesUsecase;
  ReadMessagesUsecase readMessagesUsecase;
  ReadMessagesByConversationUsecase readMessagesByConversationUsecase;
  SendGroupMessageUsecase sendGroupMessageUsecase;
  MessageCubit({
    required this.getMessagesUsecase,
    required this.sendGroupMessageUsecase,
    required this.readMessagesUsecase,
    required this.sendMessageUsecase,
    required this.listenMessagesUsecase,
    required this.readMessagesByConversationUsecase,
  }) : super(MessageInitial()) {
    helperClass = GetMessageHelper(conversationId: 0);
  }

  decryptMessages(
      {required List<Message> messages, required BigInt? otherPartyPublicKey}) async {
    if (otherPartyPublicKey == null) {
      return <Message>[];
    }

    BigInt sharedSecret = await DiffieHellmanEncryption.generateSharedSecret(
        receiverPublicKey: otherPartyPublicKey);

    for (var i = 0; i < messages.length; i++) {
      if (messages[i].encrypted == false) {
        continue;
      }
      final message = await DiffieHellmanEncryption.decryptMessageRCase(
          secretKey: sharedSecret, message: messages[i].message);
      if (message == null) {
        messages[i] = messages[i].copyWith(message: 'Message could not be decrypted');
        continue;
      }
      messages[i] = messages[i].copyWith(message: message);
    }

    return messages;
  }

  Future<List<Message>> getMessages(
      {required BigInt receiverPublicKey,
      GetMessageHelper? helper,
      bool isUIRefresh = false,
      bool refreshScroll = false}) async {
    if (isUIRefresh) {
      emit(MessageLoading());

      emit(const MessageLoaded(messages: []));
    }

    isLoading = true;
    if (!hasMore) return [];

    if (refreshScroll) refresh();
    if (helper != null) helperClass = helper;
    helperClass = helperClass.copyWith(offset: fetchedData.length);

    emit(MessageLoading());

    final response = await getMessagesUsecase(helperClass);
    response.fold(
      (l) {
        fetchedData.clear();

        emit(MessageError(message: l.message));
      },
      (r) async {
        List<Message> decryptedMessages =
            await decryptMessages(messages: r, otherPartyPublicKey: receiverPublicKey);

        fetchedData.addAll(decryptedMessages);
        isFirstFetching = false;
        hasMore = r.isNotEmpty;
        isLoading = false;

        emit(MessageLoaded(messages: r));
      },
    );
    return fetchedData;
  }

  sendMessage(
      {required SendMessageHelper message,
      required BigInt recieverPublicKey,
      required bool encryptMessage}) async {
    if (encryptMessage) {
      message.messageText = (await DiffieHellmanEncryption.encryptMessageRCase(
              message: message.messageText, receiverPublicKey: recieverPublicKey))
          .toString();
    }
    message.senderId = (await SharedPreferencesUserManager.getUser())?.user.id ?? '';

    final response = await sendMessageUsecase(message);
    response.fold(
      (l) {
        CustomFlasher.showError(l.message);
      },
      (r) => null,
    );
  }

  sendGroupMessage({required SendGroupMessageHelper helper}) async {
    final response = await sendGroupMessageUsecase(helper);
    response.fold(
      (l) {
        CustomFlasher.showError(l.message);
      },
      (r) => null,
    );
  }

  void listenMessages(
      {required int conversationId,
      required BigInt otherPartyPublicKey,
      required bool decryptMessage}) async {
    final response = await listenMessagesUsecase(
      ListenMessageHelper(
        conversationId: conversationId,
        callBackFunc: ({required message}) async {
          emit(MessageLoading());
          List<Message> messages = [message];
          if (decryptMessage) {
            messages = await decryptMessages(
                messages: [message], otherPartyPublicKey: otherPartyPublicKey);
          }

          fetchedData.insert(0, messages[0]);
          emit(MessageLoaded(messages: fetchedData));
        },
      ),
    );
    response.fold(
      (l) {
        CustomFlasher.showError(l.message);
      },
      (r) => null,
    );
  }

  readMessages({required ReadMessagesHelper helper}) async {
    final response = await readMessagesUsecase(helper);
    response.fold(
      (l) {
        CustomFlasher.showError(l.message);
      },
      (r) => null,
    );
  }

  readMessagesByConversation({required ReadMessagesHelper helper}) async {
    final response = await readMessagesByConversationUsecase(helper);
    response.fold(
      (l) {
        CustomFlasher.showError(l.message);
      },
      (r) => null,
    );
  }

  closeConversationChannels({
    required int conversationId,
  }) async {
    await SupabaseRepository.leaveMessageChannel(conversationId: conversationId);
    await SupabaseRepository.leaveEncryptionRequestChannel(
        conversationId: conversationId);
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/core/encryption/dh_base.dart';
import 'package:eunoia_chat_application/core/encryption/diffie_hellman_encryption.dart';
import 'package:eunoia_chat_application/core/secure_storage/customized_secure_storage.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/message.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/mixins/cubit_scrolling_mixin.dart';
import '../../../../core/shared_preferences/shared_preferences_user_manager.dart';
import '../../../../injection.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/entities/helper/get_conversations_helper.dart';
import '../../domain/usecases/get_conversations_usecase.dart';
import '../../domain/usecases/listen_conversations_usecase.dart';

part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState>
    with CubitScrollingMixin<Conversation, GetConversationsHelper> {
  GetConversationsUsecase getConversationsUsecase;
  ListenConversationsUsecase listenConversationsUsecase;

  ConversationCubit({
    required this.getConversationsUsecase,
    required this.listenConversationsUsecase,
  }) : super(ConversationInitial()) {
    helperClass = GetConversationsHelper();
  }

  getConversations(
      {GetConversationsHelper? helper,
      bool isUIRefresh = false,
      bool refreshScroll = false}) async {
    isLoading = true;
    if (isUIRefresh) {
      emit(ConversationsLoading());
      emit(ConversationsLoaded(conversations: fetchedData));
    }
    final String? id = (await SharedPreferencesUserManager.getUser())?.user.id;
    if (id == null) {
      return emit(
          ConversationsError(message: mainContext!.localization?.user_not_found ?? ""));
    }
    if (!hasMore) return;
    if (helper != null) helperClass = helper;
    if (refreshScroll) refresh();

    emit(ConversationsLoading());

    helperClass = helperClass.copyWith(offset: fetchedData.length, userId: id);

    final response = getConversationsUsecase.call(helperClass);

    response.then((value) async {
      value.fold(
        (error) {
          fetchedData.clear();
          emit(ConversationsError(message: error.message));
        },
        (conversations) async {
          isFirstFetching = false;
          for (var i = 0; i < conversations.length; i++) {
            if (conversations[i].lastMessage == null ||
                conversations[i].lastMessageOwnerPublicKey == null) {
              continue;
            }
            final String? message = await decryptLastMessage(
              lastMessage: conversations[i].lastMessage!,
              otherPartyPublicKey: BigInt.parse(
                conversations[i].lastMessageOwnerPublicKey!,
              ),
            );

            conversations[i] = conversations[i].copyWith(
                lastMessage: conversations[i].lastMessage!.copyWith(message: message));
          }
          fetchedData.addAll(conversations);

          hasMore = conversations.isNotEmpty;
          isLoading = false;
          emit(ConversationsLoaded(conversations: conversations));
        },
      );
    });
  }

  Future<String?> decryptLastMessage({
    required Message lastMessage,
    required BigInt? otherPartyPublicKey,
  }) async {
    final DhKey? myKeyPair = await CustomizedSecureStorage.getUserKeys();

    if (myKeyPair == null || otherPartyPublicKey == null) {
      return null;
    }

    DiffieHellmanEncryption diffieHellmanEncryption = DiffieHellmanEncryption();
    BigInt sharedSecret = diffieHellmanEncryption.generateSharedSecret(
        keyPair: myKeyPair, receiverPublicKey: otherPartyPublicKey);
    final message = diffieHellmanEncryption.decryptMessageRCase(
        secretKey: sharedSecret, message: lastMessage.message);

    lastMessage = lastMessage.copyWith(message: message);
    return lastMessage.message;
  }

  listenConversations() async {
    final response = listenConversationsUsecase.call(refreshConversations);

    response.then((value) {
      value.fold(
        (error) => emit(ConversationsError(message: error.message)),
        (conversation) {},
      );
    });
  }

  void refreshConversations({required Conversation conversation}) async {
    final String? id = (await SharedPreferencesUserManager.getUser())?.user.id;
    if (id == null) {
      return emit(
          ConversationsError(message: mainContext!.localization?.user_not_found ?? ""));
    }

    final index = fetchedData.indexWhere((element) => element.id == conversation.id);
    if (index == -1) return;
    emit(ConversationsLoading());

    fetchedData.removeAt(index);
    fetchedData.insert(0, conversation);
    emit(ConversationsLoaded(conversations: fetchedData));
  }
}

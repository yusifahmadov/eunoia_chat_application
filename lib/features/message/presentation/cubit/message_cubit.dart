import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/core/flasher/custom_flasher.dart';
import 'package:eunoia_chat_application/core/mixins/cubit_scrolling_mixin.dart';
import 'package:eunoia_chat_application/core/shared_preferences/shared_preferences_user_manager.dart';
import 'package:eunoia_chat_application/core/supabase/supabase_repository.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/get_message_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/listen_message_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/read_messages_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/send_message_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/message.dart';
import 'package:eunoia_chat_application/features/message/domain/usecases/get_messages_usecase.dart';
import 'package:eunoia_chat_application/features/message/domain/usecases/listen_messages_usecase.dart';
import 'package:eunoia_chat_application/features/message/domain/usecases/read_messages_by_conversation_usecase.dart';
import 'package:eunoia_chat_application/features/message/domain/usecases/read_messages_usecase.dart';
import 'package:eunoia_chat_application/features/message/domain/usecases/send_message_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState>
    with CubitScrollingMixin<Message, GetMessageHelper> {
  GetMessagesUsecase getMessagesUsecase;
  SendMessageUsecase sendMessageUsecase;
  ListenMessagesUsecase listenMessagesUsecase;
  ReadMessagesUsecase readMessagesUsecase;
  ReadMessagesByConversationUsecase readMessagesByConversationUsecase;

  MessageCubit({
    required this.getMessagesUsecase,
    required this.readMessagesUsecase,
    required this.sendMessageUsecase,
    required this.listenMessagesUsecase,
    required this.readMessagesByConversationUsecase,
  }) : super(MessageInitial()) {
    helperClass = GetMessageHelper(conversationId: 0);
  }

  Future<List<Message>> getMessages(
      {GetMessageHelper? helper,
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
      (r) {
        fetchedData.addAll(r);
        isFirstFetching = false;
        hasMore = r.isNotEmpty;
        isLoading = false;

        emit(MessageLoaded(messages: r));
      },
    );
    return fetchedData;
  }

  sendMessage({required SendMessageHelper message}) async {
    message.senderId = (await SharedPreferencesUserManager.getUser())?.user.id ?? '';

    final response = await sendMessageUsecase(message);
    response.fold(
      (l) {
        CustomFlasher.showError(l.message);
      },
      (r) => null,
    );
  }

  void listenMessages({required int conversationId}) async {
    final response = await listenMessagesUsecase(
      ListenMessageHelper(
        conversationId: conversationId,
        callBackFunc: ({required message}) {
          emit(MessageLoading());
          fetchedData.insert(0, message);
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
  }
}

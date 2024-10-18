import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/core/extensions/localization_extension.dart';
import 'package:eunoia_chat_application/core/mixins/cubit_scrolling_mixin.dart';
import 'package:eunoia_chat_application/core/shared_preferences/shared_preferences_user_manager.dart';
import 'package:eunoia_chat_application/features/chat/domain/entities/conversation.dart';
import 'package:eunoia_chat_application/features/chat/domain/entities/helper/get_conversations_helper.dart';
import 'package:eunoia_chat_application/features/chat/domain/usecases/get_conversations_usecase.dart';
import 'package:eunoia_chat_application/features/chat/domain/usecases/listen_conversations_usecase.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState>
    with CubitScrollingMixin<Conversation, GetConversationsHelper> {
  GetConversationsUsecase getConversationsUsecase;
  ListenConversationsUsecase listenConversationsUsecase;

  ChatCubit({
    required this.getConversationsUsecase,
    required this.listenConversationsUsecase,
  }) : super(ChatInitial()) {
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

    if (refreshScroll) refresh();

    emit(ConversationsLoading());

    helperClass = helperClass.copyWith(offset: fetchedData.length, userId: id);

    final response = getConversationsUsecase.call(helperClass);

    response.then((value) {
      value.fold(
        (error) {
          fetchedData.clear();
          emit(ConversationsError(message: error.message));
        },
        (conversations) {
          isFirstFetching = false;
          fetchedData.addAll(conversations);
          hasMore = conversations.isNotEmpty;
          isLoading = false;
          emit(ConversationsLoaded(conversations: conversations));
        },
      );
    });
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
    emit(ConversationsLoading());

    final String? id = (await SharedPreferencesUserManager.getUser())?.user.id;
    if (id == null) {
      return emit(
          ConversationsError(message: mainContext!.localization?.user_not_found ?? ""));
    }

    final index = fetchedData.indexWhere((element) => element.id == conversation.id);
    if (index == -1) return;
    final tmpConversation = fetchedData[index];

    fetchedData.removeAt(index);
    fetchedData.insert(
        index, conversation.copyWith(lastMessage: tmpConversation.lastMessage));
    emit(ConversationsLoaded(conversations: fetchedData));
  }
}

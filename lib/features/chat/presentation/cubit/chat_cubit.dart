import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/features/chat/domain/entities/conversation.dart';
import 'package:eunoia_chat_application/features/chat/domain/usecases/get_conversations_usecase.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  GetConversationsUsecase getConversationsUsecase;

  ChatCubit({
    required this.getConversationsUsecase,
  }) : super(ChatInitial());

  getConversations() {}
}

part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ConversationsLoading extends ChatState {}

class ConversationsLoaded extends ChatState {
  final List<Conversation> conversations;

  const ConversationsLoaded({required this.conversations});

  @override
  List<Object> get props => [conversations];
}

class ConversationsError extends ChatState {
  final String message;

  const ConversationsError({required this.message});

  @override
  List<Object> get props => [message];
}

part of 'conversation_cubit.dart';

abstract class ConversationState extends Equatable {
  const ConversationState();

  @override
  List<Object> get props => [];
}

class ConversationInitial extends ConversationState {}

class ConversationsLoading extends ConversationState {}

class ConversationsLoaded extends ConversationState {
  final List<Conversation> conversations;

  const ConversationsLoaded({required this.conversations});

  @override
  List<Object> get props => [conversations];
}

class ConversationsError extends ConversationState {
  final String message;

  const ConversationsError({required this.message});

  @override
  List<Object> get props => [message];
}

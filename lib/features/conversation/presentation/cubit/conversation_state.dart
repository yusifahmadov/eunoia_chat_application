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

class GroupDataLoading extends ConversationState {}

class GroupDataLoaded extends ConversationState {
  final List<GroupData> groupData;

  const GroupDataLoaded({required this.groupData});

  @override
  List<Object> get props => [groupData];
}

class GroupDataError extends ConversationState {
  final String message;

  const GroupDataError({required this.message});

  @override
  List<Object> get props => [message];
}

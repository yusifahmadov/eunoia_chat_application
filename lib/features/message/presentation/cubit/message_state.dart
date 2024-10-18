part of 'message_cubit.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final List<Message> messages;

  const MessageLoaded({required this.messages});

  @override
  List<Object> get props => [messages];
}

class MessageError extends MessageState {
  final String message;

  const MessageError({required this.message});

  @override
  List<Object> get props => [message];
}

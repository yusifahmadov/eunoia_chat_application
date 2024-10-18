import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/conversation.dart';
import 'package:eunoia_chat_application/features/conversation/domain/repositories/conversation_repository.dart';

class ListenConversationsUsecase
    extends Usecase<Conversation?, void Function({required Conversation conversation})> {
  ConversationRepository repository;

  ListenConversationsUsecase({required this.repository});

  @override
  Future<Either<ResponseI, Conversation?>> call(params) {
    return repository.listenConversations(params);
  }
}

import 'package:dartz/dartz.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/conversation.dart';
import '../repositories/conversation_repository.dart';

class ListenConversationsUsecase
    extends Usecase<Conversation?, void Function({required Conversation conversation})> {
  ConversationRepository repository;

  ListenConversationsUsecase({required this.repository});

  @override
  Future<Either<ResponseI, Conversation?>> call(params) {
    return repository.listenConversations(params);
  }
}

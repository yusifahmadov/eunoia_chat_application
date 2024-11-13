import 'package:dartz/dartz.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/conversation.dart';
import '../entities/helper/get_conversations_helper.dart';
import '../repositories/conversation_repository.dart';

class GetConversationsUsecase
    extends Usecase<List<Conversation>, GetConversationsHelper> {
  ConversationRepository repository;

  GetConversationsUsecase({required this.repository});

  @override
  Future<Either<ResponseI, List<Conversation>>> call(params) {
    return repository.getConversations(params);
  }
}

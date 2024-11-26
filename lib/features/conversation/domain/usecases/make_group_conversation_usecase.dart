import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/make_group_conversation_helper.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/conversation_repository.dart';

class MakeGroupConversationUsecase extends Usecase<int, MakeGroupConversationHelper> {
  ConversationRepository repository;

  MakeGroupConversationUsecase({required this.repository});

  @override
  Future<Either<ResponseI, int>> call(params) {
    return repository.makeGroupConversation(params);
  }
}

import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/add_participants_to_group_helper.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/conversation_repository.dart';

class AddParticipantsToGroupUsecase extends Usecase<void, AddParticipantsToGroupHelper> {
  ConversationRepository repository;

  AddParticipantsToGroupUsecase({required this.repository});

  @override
  Future<Either<ResponseI, void>> call(params) {
    return repository.addParticipantsToGroupConversation(params);
  }
}

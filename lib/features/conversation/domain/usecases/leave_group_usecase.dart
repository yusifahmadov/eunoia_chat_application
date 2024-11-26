import 'package:dartz/dartz.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/conversation_repository.dart';

class LeaveGroupUsecase extends Usecase<ResponseI, int> {
  ConversationRepository repository;

  LeaveGroupUsecase({required this.repository});

  @override
  Future<Either<ResponseI, ResponseI>> call(params) {
    return repository.leaveGroup(params);
  }
}

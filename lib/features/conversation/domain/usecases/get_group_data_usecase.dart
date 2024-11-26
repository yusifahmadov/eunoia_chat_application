import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/group_data.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/conversation_repository.dart';

class GetGroupDataUsecase extends Usecase<List<GroupData>, int> {
  ConversationRepository repository;

  GetGroupDataUsecase({required this.repository});

  @override
  Future<Either<ResponseI, List<GroupData>>> call(params) {
    return repository.getGroupData(params);
  }
}

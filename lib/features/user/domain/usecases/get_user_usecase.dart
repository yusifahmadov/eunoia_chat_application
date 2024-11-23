import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/participant.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/user_repository.dart';

class GetUserUsecase extends Usecase<List<Participant>, int> {
  UserRepository userRepository;

  GetUserUsecase({required this.userRepository});

  @override
  Future<Either<ResponseI, List<Participant>>> call(params) {
    return userRepository.getUser(conversationId: params);
  }
}

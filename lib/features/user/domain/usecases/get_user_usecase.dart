import 'package:dartz/dartz.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserUsecase extends Usecase<List<User>, int> {
  UserRepository userRepository;

  GetUserUsecase({required this.userRepository});

  @override
  Future<Either<ResponseI, List<User>>> call(params) {
    return userRepository.getUser(conversationId: params);
  }
}

import 'package:dartz/dartz.dart';

import '../../../../core/response/no_params.dart';
import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetCurrentUserUsecase extends Usecase<User, NoParams> {
  UserRepository userRepository;

  GetCurrentUserUsecase({required this.userRepository});

  @override
  Future<Either<ResponseI, User>> call(params) {
    return userRepository.getCurrentUser();
  }
}

import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/features/user/data/models/auth_response_model.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/auth_response.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/user_login_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/user_register_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<ResponseI, AuthResponse>> login(UserLoginHelper body);
  Future<Either<ResponseI, AuthResponse>> register(UserRegisterHelper body);
  Future<Either<ResponseI, AuthResponseModel>> refreshToken(
      {required String refreshToken});

  Future<Either<ResponseI, List<User>>> getUser({required int conversationId});
  Future<Either<ResponseI, User>> getCurrentUser();
}

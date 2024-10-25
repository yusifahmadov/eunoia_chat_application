import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/features/user/data/datasources/user_remote_data_source.dart';
import 'package:eunoia_chat_application/features/user/data/models/auth_response_model.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/auth_response.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/user_login_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/user_register_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/user.dart';
import 'package:eunoia_chat_application/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Future<Either<ResponseI, AuthResponse>> login(UserLoginHelper body) async {
    try {
      return Right(await userRemoteDataSource.login(body));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, AuthResponse>> register(UserRegisterHelper body) async {
    try {
      return Right(await userRemoteDataSource.register(body));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, AuthResponseModel>> refreshToken(
      {required String refreshToken}) async {
    try {
      return Right(await userRemoteDataSource.refreshToken(refreshToken));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, List<User>>> getUser({required int conversationId}) async {
    try {
      return Right(await userRemoteDataSource.getUser(conversationId));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, User>> getCurrentUser() async {
    try {
      return Right(await userRemoteDataSource.getCurrentUser());
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }
}

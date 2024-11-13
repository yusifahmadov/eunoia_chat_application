import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/upload_user_profile_photo_helper.dart';

import '../../../../core/response/response.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/entities/helper/user_login_helper.dart';
import '../../domain/entities/helper/user_register_helper.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/auth_response_model.dart';

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

  @override
  Future<Either<ResponseI, void>> updateUserProfilePhoto(
      UploadUserProfilePhotoHelper body) async {
    try {
      return Right(await userRemoteDataSource.updateUserProfilePhoto(body));
    } on DioException catch (e) {
      print(e.response.toString());
      return Left(ResponseI(message: e.response.toString()));
    }
  }
}

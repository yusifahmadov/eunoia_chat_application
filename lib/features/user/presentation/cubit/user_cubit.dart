import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/core/constant/constants.dart';
import 'package:eunoia_chat_application/core/extensions/localization_extension.dart';
import 'package:eunoia_chat_application/core/flasher/custom_flasher.dart';
import 'package:eunoia_chat_application/core/shared_preferences/custom_shared_preferences.dart';
import 'package:eunoia_chat_application/features/user/data/models/auth_response_model.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/auth_response.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/user_login_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/user_register_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/user.dart';
import 'package:eunoia_chat_application/features/user/domain/usecases/get_user_usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/usecases/refresh_token_usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/usecases/user_login_usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/usecases/user_register_usecase.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserLoginUsecase userLoginUsecase;
  UserRegisterUsecase userRegisterUsecase;
  RefreshTokenUsecase refreshTokenUsecase;
  GetUserUsecase getUserUsecase;
  UserCubit({
    required this.userLoginUsecase,
    required this.userRegisterUsecase,
    required this.refreshTokenUsecase,
    required this.getUserUsecase,
  }) : super(UserInitial());

  login({required UserLoginHelper body}) async {
    final response = await userLoginUsecase.call(body);
    response.fold(
      (error) {
        CustomFlasher.showError(error.message);
        emit(UserLoginError(message: error.message));
      },
      (data) {
        authCubit.authenticate(body: data);
        CustomFlasher.showSuccess(mainContext?.localization?.login_success);
        emit(UserLoginSuccess(authResponse: data));
      },
    );
  }

  register({required UserRegisterHelper body}) async {
    emit(UserRegisterLoading());
    final response = await userRegisterUsecase.call(body);
    response.fold(
      (error) {
        CustomFlasher.showError(error.message);
        emit(UserRegisterError(message: error.message));
      },
      (data) {
        authCubit.authenticate(body: data);
        emit(UserRegisterSuccess(authResponse: data));
      },
    );
  }

  Future<String> refreshToken() async {
    final response = await refreshTokenUsecase(
      AuthResponseModel.fromJson((await CustomSharedPreferences.readUser('user'))!)
          .refreshToken,
    );
    var token = '';
    CustomFlasher.showSuccess('Sizin sessiya yeniləndi!');
    response.fold((l) => '', (r) => token = r.accessToken);
    return token;
  }

  getUser({required String id}) async {
    final response = await getUserUsecase(id);

    response.fold(
      (error) async {
        emit(UserDetailError(message: error.message));
      },
      (user) async {
        emit(UserDetailSuccess(users: user));
      },
    );
  }
}

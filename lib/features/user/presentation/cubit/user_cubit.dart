import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/upload_user_profile_photo_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/usecases/update_user_profile_photo_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/constants.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/flasher/custom_flasher.dart';
import '../../../../core/response/no_params.dart';
import '../../../../core/shared_preferences/custom_shared_preferences.dart';
import '../../../../injection.dart';
import '../../data/models/auth_response_model.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/entities/helper/user_login_helper.dart';
import '../../domain/entities/helper/user_register_helper.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/get_user_usecase.dart';
import '../../domain/usecases/refresh_token_usecase.dart';
import '../../domain/usecases/user_login_usecase.dart';
import '../../domain/usecases/user_register_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserLoginUsecase userLoginUsecase;
  UserRegisterUsecase userRegisterUsecase;
  RefreshTokenUsecase refreshTokenUsecase;
  GetUserUsecase getUserUsecase;
  GetCurrentUserUsecase getCurrentUserUsecase;
  UpdateUserProfilePhotoUsecase updateUserProfilePhotoUsecase;
  UserCubit({
    required this.userLoginUsecase,
    required this.userRegisterUsecase,
    required this.refreshTokenUsecase,
    required this.getUserUsecase,
    required this.getCurrentUserUsecase,
    required this.updateUserProfilePhotoUsecase,
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

  Future<List<User>> getUser({required int conversationId}) async {
    final response = await getUserUsecase(conversationId);
    List<User> tmpList = [];
    response.fold(
      (error) async {
        tmpList = [];
        emit(UserDetailError(message: error.message));
      },
      (user) async {
        tmpList = user;
        emit(UserDetailSuccess(users: user));
      },
    );
    return tmpList;
  }

  getCurrentUserInformation() async {
    emit(CurrentUserLoading());

    final response = await getCurrentUserUsecase(NoParams());

    response.fold(
      (e) => emit(CurrentUserError(message: e.message)),
      (user) => emit(CurrentUserSuccess(user: user)),
    );
  }

  updateUserProfilePhoto(
      {required UploadUserProfilePhotoHelper body, void Function()? whenSuccess}) async {
    final response = await updateUserProfilePhotoUsecase(body);
    response.fold(
      (error) {
        CustomFlasher.showError(error.message);
      },
      (data) {
        CustomFlasher.showSuccess(
            mainContext?.localization?.update_profile_photo_success);

        if (whenSuccess != null) whenSuccess();
      },
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/core/constant/constants.dart';
import 'package:eunoia_chat_application/core/flasher/custom_flasher.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/auth_response.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/user_login_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/user_register_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/usecases/user_login_usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/usecases/user_register_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserLoginUsecase userLoginUsecase;
  UserRegisterUsecase userRegisterUsecase;
  UserCubit({required this.userLoginUsecase, required this.userRegisterUsecase})
      : super(UserInitial());

  login({required UserLoginHelper body}) async {
    final response = await userLoginUsecase.call(body);
    response.fold(
      (error) {
        CustomFlasher.showError(error.message);
        emit(UserLoginError(message: error.message));
      },
      (data) {
        authCubit.authenticate(body: data);
        CustomFlasher.showSuccess('Giriş edildi!');
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
}

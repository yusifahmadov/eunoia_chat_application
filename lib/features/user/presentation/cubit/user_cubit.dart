import 'package:diffie_hellman/diffie_hellman.dart';
import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/core/secure_storage/customized_secure_storage.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/participant.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/set_public_key_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/update_user_information_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/upload_user_profile_photo_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/usecases/set_e2ee_status_usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/usecases/set_public_key_usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/usecases/update_user_information_usecase.dart';
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
  SetPublicKeyUsecase setPublicKeyUsecase;
  UpdateUserInformationUsecase updateUserInformationUsecase;
  SetE2eeStatusUsecase setE2eeStatusUsecase;
  UserCubit({
    required this.userLoginUsecase,
    required this.setE2eeStatusUsecase,
    required this.userRegisterUsecase,
    required this.refreshTokenUsecase,
    required this.getUserUsecase,
    required this.getCurrentUserUsecase,
    required this.updateUserProfilePhotoUsecase,
    required this.setPublicKeyUsecase,
    required this.updateUserInformationUsecase,
  }) : super(UserInitial());

  login({required UserLoginHelper body}) async {
    final response = await userLoginUsecase.call(body);
    response.fold(
      (error) {
        CustomFlasher.showError(error.message);
        emit(UserLoginError(message: error.message));
      },
      (data) async {
        await storeUserInformation(body: data);
        await storeKeyEngine();
        setPublicKey();
        authCubit.authenticate(body: data);

        CustomFlasher.showSuccess(mainContext?.localization?.login_success);
        emit(UserLoginSuccess(authResponse: data));
      },
    );
  }

  storeKeyEngine() async {
    DhPkcs3Engine dhEngine = DhPkcs3Engine.fromGroup(DhGroup.g5);
    dhEngine.generateKeyPair();
    await CustomizedSecureStorage.storeDhEngine(engine: dhEngine);
  }

  register({required UserRegisterHelper body}) async {
    emit(UserRegisterLoading());
    final response = await userRegisterUsecase.call(body);
    response.fold(
      (error) {
        CustomFlasher.showError(error.message);
        emit(UserRegisterError(message: error.message));
      },
      (data) async {
        await storeUserInformation(body: data);
        setPublicKey();
        authCubit.authenticate(body: data);
        emit(UserRegisterSuccess(authResponse: data));
      },
    );
  }

  storeUserInformation({required AuthResponse body}) async {
    await CustomSharedPreferences.saveUser("user", body);
  }

  Future<String> refreshToken() async {
    final response = await refreshTokenUsecase(
      AuthResponseModel.fromJson((await CustomSharedPreferences.readUser('user'))!)
          .refreshToken,
    );
    var token = '';
    CustomFlasher.showSuccess(mainContext?.localization?.refresh_token_success);
    response.fold((l) => '', (r) => token = r.accessToken);
    return token;
  }

  Future<List<Participant>> getUser({required int conversationId}) async {
    List<Participant> tmpList = [];

    await getUserUsecase(conversationId).then((value) => value.fold(
          (error) {
            CustomFlasher.showError(error.message);
            tmpList = [];
            emit(UserDetailError(message: error.message));
          },
          (data) {
            tmpList = data;
            emit(UserDetailSuccess(users: data));
          },
        ));
    return tmpList;
  }

  Future<User?> getCurrentUserInformation() async {
    emit(CurrentUserLoading());
    User? tmpUser;
    final response = await getCurrentUserUsecase(NoParams());

    response.fold(
      (e) {
        tmpUser = null;
        emit(CurrentUserError(message: e.message));
      },
      (user) {
        tmpUser = user;
        emit(CurrentUserSuccess(user: user));
      },
    );

    return tmpUser;
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

  setPublicKey({bool forceChange = false}) async {
    SetPublicKeyHelper tmpHelper = SetPublicKeyHelper(forceChange: false, publicKey: '');

    final DhPkcs3Engine? engine = await CustomizedSecureStorage.getDhEngine();

    if (engine == null || engine.keyPair == null) {
      return;
    }

    if (forceChange) {
      tmpHelper = SetPublicKeyHelper(
          forceChange: true, publicKey: engine.keyPair!.publicKey.value.toString());
    }
    tmpHelper = tmpHelper.copyWith(publicKey: engine.keyPair!.publicKey.value.toString());

    final result = await setPublicKeyUsecase(tmpHelper);

    result.fold(
      (error) async {
        /// Although the public is already set, we need to store it in the secure storage

        if (!await CustomizedSecureStorage.checkPrivateKey()) {
          print('NO PRIVATE KEY AND WE NEED TO SET IT');
          setPublicKey(forceChange: true);
        }
      },
      (data) async {
        print('SAVED NEW PUBLIC KEY');
        await CustomizedSecureStorage.setNewPublicKey(publicKey: data);
        await CustomizedSecureStorage.setNewPrivateKey(
            privateKey: engine.keyPair!.privateKey.toString());
        await CustomizedSecureStorage.storeDhEngine(engine: engine);
      },
    );
  }

  updateUserInformation(
      {required UpdateUserInformationHelper helper, void Function()? whenSuccess}) async {
    final response = await updateUserInformationUsecase(helper);
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

  setE2eeStatus({required bool status, void Function()? whenSuccess}) async {
    final response = await setE2eeStatusUsecase(status);
    response.fold(
      (error) {
        CustomFlasher.showError(error.message);
      },
      (data) {
        CustomFlasher.showSuccess(data.message);
        whenSuccess?.call();
      },
    );
  }
}

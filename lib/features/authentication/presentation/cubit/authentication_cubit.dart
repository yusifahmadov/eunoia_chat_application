import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/flasher/custom_flasher.dart';
import '../../../../core/shared_preferences/custom_shared_preferences.dart';
import '../../../../injection.dart';
import '../../../user/data/models/auth_response_model.dart';
import '../../../user/domain/entities/auth_response.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  init() async {
    emit(AuthenticationInitial());
    final user = await readUserInformation();
    if (user != null) {
      emit(AuthenticationAuthenticated(authResponse: user));
      return;
    }
    emit(AuthenticationUnauthenticated());
  }

  authenticate({required AuthResponse body}) async {
    emit(AuthenticationLoading());
    await storeUserInformation(body: body);

    emit(AuthenticationAuthenticated(authResponse: body));
  }

  storeUserInformation({required AuthResponse body}) async {
    await CustomSharedPreferences.saveUser("user", body);
  }

  Future<AuthResponse?> readUserInformation() async {
    final user = AuthResponseModel.fromJson(
        await CustomSharedPreferences.readUser("user") as Map<String, dynamic>);

    print(user.accessToken);
    return user;
  }

  logout() async {
    emit(AuthenticationLoading());
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    CustomFlasher.showSuccess(mainContext?.localization?.logout_success);

    emit(AuthenticationUnauthenticated());
  }
}

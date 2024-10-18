import 'package:equatable/equatable.dart';
import 'package:eunoia_chat_application/core/flasher/custom_flasher.dart';
import 'package:eunoia_chat_application/core/shared_preferences/custom_shared_preferences.dart';
import 'package:eunoia_chat_application/features/user/data/models/auth_response_model.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/auth_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return user;
  }

  logout() async {
    emit(AuthenticationLoading());
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    CustomFlasher.showSuccess('Çıxış edildi!');

    emit(AuthenticationUnauthenticated());
  }
}

import 'package:flutter/material.dart';

import '../../../../../injection.dart';
import '../../../domain/entities/helper/user_register_helper.dart';
import '../../cubit/user_cubit.dart';
import 'sign_up_page.dart';
import 'signup_provider.dart';

class SignupProviderWidget extends StatefulWidget {
  const SignupProviderWidget({super.key});

  @override
  State<SignupProviderWidget> createState() => SignupProviderState();
}

class SignupProviderState extends State<SignupProviderWidget> {
  UserRegisterHelper userRegisterHelper = const UserRegisterHelper();
  final userCubit = getIt<UserCubit>();

  register() {
    userCubit.register(body: userRegisterHelper);
  }

  @override
  Widget build(BuildContext context) {
    return SignupProvider(state: this, child: const SignUpPage());
  }
}

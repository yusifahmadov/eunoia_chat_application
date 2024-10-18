import 'package:eunoia_chat_application/features/user/domain/entities/helper/user_register_helper.dart';
import 'package:eunoia_chat_application/features/user/presentation/cubit/user_cubit.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/signup/sign_up_page.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/signup/signup_provider.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';

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

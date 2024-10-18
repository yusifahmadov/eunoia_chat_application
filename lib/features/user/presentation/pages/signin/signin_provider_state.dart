import 'package:eunoia_chat_application/features/user/domain/entities/helper/user_login_helper.dart';
import 'package:eunoia_chat_application/features/user/presentation/cubit/user_cubit.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/signin/sign_in_page.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/signin/signin_provider.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';

class SigninProviderWidget extends StatefulWidget {
  const SigninProviderWidget({super.key});

  @override
  State<SigninProviderWidget> createState() => SigninProviderState();
}

class SigninProviderState extends State<SigninProviderWidget> {
  final userCubit = getIt<UserCubit>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  signIn() {
    userCubit.login(
        body: UserLoginHelper(
            email: emailController.text, password: passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return SigninProvider(state: this, child: const SignInPage());
  }
}

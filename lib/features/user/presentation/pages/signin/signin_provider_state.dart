import 'package:flutter/material.dart';

import '../../../../../injection.dart';
import '../../../domain/entities/helper/user_login_helper.dart';
import '../../cubit/user_cubit.dart';
import 'sign_in_page.dart';
import 'signin_provider.dart';

class SigninProviderWidget extends StatefulWidget {
  const SigninProviderWidget({super.key});

  @override
  State<SigninProviderWidget> createState() => SigninProviderState();
}

class SigninProviderState extends State<SigninProviderWidget> {
  final userCubit = getIt<UserCubit>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  signIn() {
    if (!formKey.currentState!.validate()) return;

    userCubit.login(
        body: UserLoginHelper(
            email: emailController.text, password: passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return SigninProvider(state: this, child: const SignInPage());
  }
}

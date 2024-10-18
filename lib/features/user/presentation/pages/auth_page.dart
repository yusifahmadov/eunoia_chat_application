import 'package:eunoia_chat_application/features/user/presentation/pages/signin/signin_provider_state.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SigninProviderWidget(),
    );
  }
}

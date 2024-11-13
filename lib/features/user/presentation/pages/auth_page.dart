import 'package:flutter/material.dart';

import 'signin/signin_provider_state.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SigninProviderWidget(),
    );
  }
}

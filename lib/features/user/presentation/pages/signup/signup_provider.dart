import 'package:eunoia_chat_application/features/user/presentation/pages/signup/signup_provider_state.dart';
import 'package:flutter/material.dart';

class SignupProvider extends InheritedWidget {
  final SignupProviderState state;
  const SignupProvider({super.key, required super.child, required this.state});

  static SignupProviderState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<SignupProvider>();
    if (result == null) {
      throw Exception('Provider not found');
    }
    return result.state;
  }

  @override
  bool updateShouldNotify(SignupProvider oldWidget) {
    return false;
  }
}

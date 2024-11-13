import 'package:flutter/widgets.dart';

import 'signin_provider_state.dart';

class SigninProvider extends InheritedWidget {
  final SigninProviderState state;
  const SigninProvider({super.key, required super.child, required this.state});

  static SigninProviderState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<SigninProvider>();
    if (result == null) {
      throw Exception('Could not find SigninProvider');
    }
    return result.state;
  }

  @override
  bool updateShouldNotify(SigninProvider oldWidget) {
    return false;
  }
}

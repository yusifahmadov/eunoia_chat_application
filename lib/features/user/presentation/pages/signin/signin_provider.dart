import 'package:eunoia_chat_application/features/user/presentation/pages/signin/signin_provider_state.dart';
import 'package:flutter/widgets.dart';

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

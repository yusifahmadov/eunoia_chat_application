import 'package:eunoia_chat_application/features/user/presentation/pages/language/language_provider_state.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends InheritedWidget {
  final LanguageProviderState state;
  const LanguageProvider({super.key, required super.child, required this.state});

  static LanguageProviderState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<LanguageProvider>();

    if (result == null) {
      throw Exception('LanguageProvider not found in context');
    }
    return result.state;
  }

  @override
  bool updateShouldNotify(LanguageProvider oldWidget) {
    return false;
  }
}

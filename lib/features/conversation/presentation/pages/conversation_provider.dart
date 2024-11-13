import 'package:flutter/material.dart';

import 'conversation_provider_state.dart';

class ConversationProvider extends InheritedWidget {
  final ConversationProviderState state;
  const ConversationProvider({
    super.key,
    required super.child,
    required this.state,
  });

  static ConversationProviderState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<ConversationProvider>();
    if (result == null) {
      throw Exception("ChatProvider not found in context");
    }
    return result.state;
  }

  @override
  bool updateShouldNotify(ConversationProvider oldWidget) {
    return false;
  }
}

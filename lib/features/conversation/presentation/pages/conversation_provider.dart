import 'package:eunoia_chat_application/features/conversation/presentation/pages/conversation_provider_state.dart';
import 'package:flutter/material.dart';

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

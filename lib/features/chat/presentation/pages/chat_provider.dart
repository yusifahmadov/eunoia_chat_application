import 'package:eunoia_chat_application/features/chat/presentation/pages/chat_provider_state.dart';
import 'package:flutter/material.dart';

class ChatProvider extends InheritedWidget {
  final ChatProviderState state;
  const ChatProvider({
    super.key,
    required super.child,
    required this.state,
  });

  static ChatProviderState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<ChatProvider>();
    if (result == null) {
      throw Exception("ChatProvider not found in context");
    }
    return result.state;
  }

  @override
  bool updateShouldNotify(ChatProvider oldWidget) {
    return false;
  }
}

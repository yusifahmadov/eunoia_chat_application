import 'package:eunoia_chat_application/features/message/presentation/pages/message_provider_state.dart';
import 'package:flutter/widgets.dart';

class MessageProvider extends InheritedWidget {
  final MessageProviderState state;
  const MessageProvider({super.key, required super.child, required this.state});

  static MessageProviderState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<MessageProvider>();
    if (result == null) {
      throw Exception('MessageProvider not found in context');
    }
    return result.state;
  }

  @override
  bool updateShouldNotify(MessageProvider oldWidget) {
    return false;
  }
}

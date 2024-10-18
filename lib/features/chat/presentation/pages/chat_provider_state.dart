import 'package:eunoia_chat_application/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:eunoia_chat_application/features/chat/presentation/pages/chat_page.dart';
import 'package:eunoia_chat_application/features/chat/presentation/pages/chat_provider.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';

class ChatProviderWidget extends StatefulWidget {
  const ChatProviderWidget({super.key});

  @override
  State<ChatProviderWidget> createState() => ChatProviderState();
}

class ChatProviderState extends State<ChatProviderWidget> {
  final chatCubit = getIt<ChatCubit>();

  @override
  void initState() {
    chatCubit.getConversations();
    chatCubit.listenConversations();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChatProvider(
      state: this,
      child: const ChatPage(),
    );
  }
}

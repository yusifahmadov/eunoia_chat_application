import 'package:eunoia_chat_application/core/mixins/page_scrolling_mixin.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/cubit/conversation_cubit.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/conversation_page.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/conversation_provider.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';

class ConversationProviderWidget extends StatefulWidget {
  const ConversationProviderWidget({super.key});

  @override
  State<ConversationProviderWidget> createState() => ConversationProviderState();
}

class ConversationProviderState extends State<ConversationProviderWidget>
    with PageScrollingMixin {
  final chatCubit = getIt<ConversationCubit>();

  @override
  void initState() {
    initializeScrolling(function: () async {
      chatCubit.getConversations();
    });
    chatCubit.listenConversations();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConversationProvider(
      state: this,
      child: const ConversationPage(),
    );
  }
}

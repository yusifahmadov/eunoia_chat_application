import 'package:flutter/material.dart';

import '../../../../core/mixins/page_scrolling_mixin.dart';
import '../../../../injection.dart';
import '../cubit/conversation_cubit.dart';
import 'conversation_page.dart';
import 'conversation_provider.dart';

class ConversationProviderWidget extends StatefulWidget {
  const ConversationProviderWidget({super.key});

  @override
  State<ConversationProviderWidget> createState() => ConversationProviderState();
}

class ConversationProviderState extends State<ConversationProviderWidget>
    with PageScrollingMixin {
  final conversationCubit = getIt<ConversationCubit>();

  @override
  void initState() {
    initializeScrolling(function: () async {
      conversationCubit.getConversations();
    });
    conversationCubit.listenConversations();
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

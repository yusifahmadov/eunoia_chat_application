import 'package:eunoia_chat_application/core/constant/constants.dart';
import 'package:eunoia_chat_application/core/supabase/supabase_repository.dart';
import 'package:flutter/material.dart';

import '../../../../core/mixins/page_scrolling_mixin.dart';
import 'conversation_page.dart';
import 'conversation_provider.dart';

class ConversationProviderWidget extends StatefulWidget {
  const ConversationProviderWidget({super.key});

  @override
  State<ConversationProviderWidget> createState() => ConversationProviderState();
}

class ConversationProviderState extends State<ConversationProviderWidget>
    with PageScrollingMixin {
  @override
  void initState() {
    initializeScrolling(function: () async {
      conversationCubit.getConversations();
    });
    conversationCubit.listenConversations();
    // SupabaseRepository.listenMessagesAdvanced();
    super.initState();
  }

  @override
  void dispose() {
    SupabaseRepository.closeSocket();
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

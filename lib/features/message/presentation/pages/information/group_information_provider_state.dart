import 'package:eunoia_chat_application/core/constant/constants.dart';
import 'package:eunoia_chat_application/core/list_notifier.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/conversation.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/conversation_participant.dart';
import 'package:eunoia_chat_application/features/message/presentation/pages/information/group_information_page.dart';
import 'package:eunoia_chat_application/features/message/presentation/pages/information/group_information_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupInformationProviderWidget extends StatefulWidget {
  const GroupInformationProviderWidget(
      {super.key, required this.conversation, required this.userId});
  final Conversation conversation;
  final String userId;
  @override
  State<GroupInformationProviderWidget> createState() => GroupInformationProviderState();
}

class GroupInformationProviderState extends State<GroupInformationProviderWidget> {
  ListNotifier<ConversationParticipant> participants =
      ListNotifier<ConversationParticipant>();
  getGroupInformation() async {
    final tmpGroupData = await conversationCubit.getGroupData(
      conversationId: widget.conversation.id,
    );

    if (tmpGroupData != null) {
      for (var i = 0; i < tmpGroupData.participants.length; i++) {
        participants.add(tmpGroupData.participants[i]);
      }
    }
  }

  updateParticipant({required List<ConversationParticipant> users}) {
    for (final user in users) {
      if (!participants.contains(user)) {
        participants.add(user);
      }
    }
  }

  leaveGroup() async {
    await conversationCubit.leaveGroup(
      conversationId: widget.conversation.id,
      whenSuccess: () {
        context.pop();
        context.pop(conversationCubit.getConversations());
      },
    );
  }

  @override
  void initState() {
    getGroupInformation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GroupInformationProvider(state: this, child: const GroupInformationPage());
  }
}

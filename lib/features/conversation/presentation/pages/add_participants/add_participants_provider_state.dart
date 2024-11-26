import 'package:eunoia_chat_application/core/list_notifier.dart';
import 'package:eunoia_chat_application/core/mixins/debouncer_mixin.dart';
import 'package:eunoia_chat_application/core/mixins/page_scrolling_mixin.dart';
import 'package:eunoia_chat_application/features/contact/presentation/cubit/contact_cubit.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/add_participants_to_group_helper.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/cubit/conversation_cubit.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/add_participants/add_participants_page.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/add_participants/add_participants_provider.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/conversation_participant.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddParticipantsProviderWidget extends StatefulWidget {
  const AddParticipantsProviderWidget(
      {super.key,
      required this.updateParticipant,
      this.conversationId,
      this.conversationCubit});
  final void Function({required List<ConversationParticipant> users})? updateParticipant;
  final int? conversationId;
  final ConversationCubit? conversationCubit;
  @override
  State<AddParticipantsProviderWidget> createState() => AddParticipantsProviderState();
}

class AddParticipantsProviderState extends State<AddParticipantsProviderWidget>
    with DebouncerSearchMixin, PageScrollingMixin {
  final contactCubit = getIt<ContactCubit>();
  ListNotifier<ConversationParticipant> participants =
      ListNotifier<ConversationParticipant>();
  @override
  void initState() {
    initializeScrolling(function: () async {
      await contactCubit.getContacts();
    });
    super.initState();
  }

  updateParticipantStream({required ConversationParticipant user}) {
    if (participants.contains(user)) {
      participants.remove(user);
    } else {
      participants.add(user);
    }
  }

  addParticipants() {
    if (widget.updateParticipant == null && widget.conversationId != null) {
      widget.conversationCubit?.addParticipantsToGroupConversation(
          fromExistingGroup: true,
          body: AddParticipantsToGroupHelper(
              groupId: widget.conversationId!, participants: participants.value),
          whenSuccess: () {});
    }

    widget.updateParticipant?.call(users: participants.value);
    context.pop();
  }

  searchContacts({required String query}) async {
    contactCubit.helperClass = contactCubit.helperClass.copyWith(username: query);
    contactCubit.getContacts(refreshScroll: true);
  }

  @override
  Widget build(BuildContext context) {
    return AddParticipantsProvider(state: this, child: const AddParticipantsPage());
  }
}

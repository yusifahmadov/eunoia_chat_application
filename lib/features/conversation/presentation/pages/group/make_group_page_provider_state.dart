import 'dart:io';

import 'package:eunoia_chat_application/core/list_notifier.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/add_group_photo_helper.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/add_participants_to_group_helper.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/make_group_conversation_helper.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/cubit/conversation_cubit.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/group/make_group_page.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/group/make_group_page_provider.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/conversation_participant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MakeGroupPageProviderWidget extends StatefulWidget {
  const MakeGroupPageProviderWidget({super.key, required this.conversationCubit});
  final ConversationCubit conversationCubit;
  @override
  State<MakeGroupPageProviderWidget> createState() => MakeGroupPageProviderState();
}

class MakeGroupPageProviderState extends State<MakeGroupPageProviderWidget> {
  final formKey = GlobalKey<FormState>();
  MakeGroupConversationHelper makeGroupConversationHelper =
      MakeGroupConversationHelper(title: "");
  AddParticipantsToGroupHelper addParticipantsToGroupHelper =
      AddParticipantsToGroupHelper(groupId: 0, participants: []);
  final ValueNotifier<File?> imageNotifier = ValueNotifier<File?>(null);
  final ListNotifier<ConversationParticipant> participants =
      ListNotifier<ConversationParticipant>();

  AddGroupPhotoHelper addGroupPhotoHelper =
      AddGroupPhotoHelper(file: File(''), fileName: '');

  makeGroupConversation() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    addParticipantsToGroupHelper = addParticipantsToGroupHelper.copyWith(
      participants: [...participants],
    );

    widget.conversationCubit.makeGroupConversation(
      body: makeGroupConversationHelper,
      addGroupPhotoHelper: addGroupPhotoHelper,
      participantsHelper: addParticipantsToGroupHelper,
      whenSuccess: () {
        context.pop();
      },
    );
  }

  updateParticipant({required List<ConversationParticipant> users}) {
    for (final user in users) {
      if (!participants.contains(user)) {
        participants.add(user);
      }
    }
  }

  removeParticipant({required ConversationParticipant user}) {
    participants.remove(user);
  }

  pickImage() {
    final pickerResult = FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
    );

    pickerResult.then((value) {
      if (value != null) {
        makeGroupConversationHelper = makeGroupConversationHelper.copyWith(
          image: File(value.files.single.path!),
        );
        imageNotifier.value = File(value.files.single.path!);

        addGroupPhotoHelper = addGroupPhotoHelper.copyWith(
          file: File(value.files.single.path!),
          fileName:
              "group_${"${makeGroupConversationHelper.title}-${DateTime.now().millisecondsSinceEpoch}"}.jpg",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MakeGroupPageProvider(state: this, child: const MakeGroupPage());
  }
}

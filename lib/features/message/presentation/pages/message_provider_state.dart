import 'package:eunoia_chat_application/core/shared_preferences/shared_preferences_user_manager.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/conversation.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/send_group_message_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/encryption_request.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/send_encryption_request_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/participant.dart';
import 'package:flutter/material.dart';

import '../../../../core/mixins/page_scrolling_mixin.dart';
import '../../../../injection.dart';
import '../../../user/presentation/cubit/user_cubit.dart';
import '../../domain/entities/helper/read_messages_helper.dart';
import '../../domain/entities/helper/send_message_helper.dart';
import '../cubit/message_cubit.dart';
import 'message_page.dart';
import 'message_provider.dart';

class MessageProviderWidget extends StatefulWidget {
  const MessageProviderWidget(
      {super.key, required this.conversation, required this.userId});
  final String userId;
  final Conversation conversation;
  @override
  State<MessageProviderWidget> createState() => MessageProviderState();
}

class MessageProviderState extends State<MessageProviderWidget> with PageScrollingMixin {
  final messageCubit = getIt<MessageCubit>();
  final userCubit = getIt<UserCubit>();
  final ValueNotifier<bool> e2eeNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<EncryptionRequest?> encryptionRequestNotifier =
      ValueNotifier<EncryptionRequest?>(null);
  final messageController = TextEditingController();
  final focusNode = FocusNode();
  BigInt userPublicKey = BigInt.zero;
  int conversationId = 0;
  List<Participant> users = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (widget.conversation.isGroup == false) {
        e2eeNotifier.value = widget.conversation.e2eeEnabled;
        messageCubit.getEncryptionRequest(
            conversationId: widget.conversation.id, userCubit: userCubit);
        users = (await userCubit.getUser(conversationId: widget.conversation.id));
        encryptionRequestNotifier.value = users[0].encryptionRequestData;
        userPublicKey = BigInt.parse(users[0].userData.publicKey ?? '0');
        messageCubit.helperClass =
            messageCubit.helperClass.copyWith(conversationId: widget.conversation.id);

        initializeScrolling(function: () async {
          await messageCubit.getMessages(receiverPublicKey: userPublicKey);
        });

        if (users.isNotEmpty && users[0].userData.publicKey != null) {
          messageCubit.listenMessages(
              decryptMessage: widget.conversation.e2eeEnabled,
              conversationId: widget.conversation.id,
              otherPartyPublicKey: userPublicKey);

          messageCubit.listenEncryptionRequest(
              conversationId: widget.conversation.id,
              current: null,
              userCubit: userCubit);
        }
      } else {
        messageCubit.helperClass =
            messageCubit.helperClass.copyWith(conversationId: widget.conversation.id);

        initializeScrolling(function: () async {
          await messageCubit.getMessages(receiverPublicKey: BigInt.zero);
        });

        messageCubit.listenMessages(
            decryptMessage: widget.conversation.e2eeEnabled,
            conversationId: widget.conversation.id,
            otherPartyPublicKey: BigInt.zero);
      }
    });

    // readMessagesByConversation();
    super.initState();
  }

  sendEncryptionRequest() async {
    showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('E2EE'),
            content: Text(
                'Do you want to ${e2eeNotifier.value == true ? 'disable' : 'enable'} E2EE? This will send a request to the other party.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    messageCubit.sendEncryptionRequest(
                        whenSuccess: () async {
                          await userCubit.getUser(conversationId: widget.conversation.id);
                        },
                        body: SendEncryptionRequestHelper(
                          conversationId: widget.conversation.id,
                          e2eeOffer: !e2eeNotifier.value,
                          receiverId: users[0].userData.id,
                          senderId:
                              (await SharedPreferencesUserManager.getUser())?.user.id ??
                                  "",
                        ));
                  },
                  child: const Text('Yes')),
            ],
          );
        });
  }

  Future<void> sendMessage({
    required String message,
  }) async {
    if (widget.conversation.isGroup) {
      await messageCubit.sendGroupMessage(
          helper: SendGroupMessageHelper(
        groupId: widget.conversation.id,
        message: message,
      ));
      return;
    }

    if (message == '' || users[0].userData.publicKey == null) return;
    await messageCubit.sendMessage(
        encryptMessage: widget.conversation.e2eeEnabled,
        recieverPublicKey: BigInt.parse(users[0].userData.publicKey!),
        message: SendMessageHelper(
            isGroup: widget.conversation.isGroup,
            senderId: '',
            messageText: message,
            receiverId: users[0].userData.id));
  }

  readMessagesByConversation() async {
    await messageCubit.readMessagesByConversation(
        helper:
            ReadMessagesHelper(userId: widget.userId, conversationId: conversationId));
  }

  @override
  void dispose() {
    messageCubit.closeConversationChannels(conversationId: conversationId);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MessageProvider(
      state: this,
      child: const MessagePage(),
    );
  }
}

import 'package:eunoia_chat_application/features/conversation/domain/entities/conversation.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/send_group_message_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/participant.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/user.dart';
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
      {super.key, required this.conversation, required this.myInformation});
  final User myInformation;
  final Conversation conversation;
  @override
  State<MessageProviderWidget> createState() => MessageProviderState();
}

class MessageProviderState extends State<MessageProviderWidget> with PageScrollingMixin {
  final messageCubit = getIt<MessageCubit>();
  final userCubit = getIt<UserCubit>();

  final ValueNotifier<bool> e2eeStatusNotifier = ValueNotifier<bool>(false);

  final messageController = TextEditingController();
  bool otherPartyE2eeEnabled = false;
  final focusNode = FocusNode();
  BigInt userPublicKey = BigInt.zero;
  int conversationId = 0;
  List<Participant> users = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (widget.conversation.isGroup == false) {
        users = (await userCubit.getUser(conversationId: widget.conversation.id));
        userPublicKey = BigInt.parse(users[0].userData.publicKey ?? '0');
        messageCubit.helperClass =
            messageCubit.helperClass.copyWith(conversationId: widget.conversation.id);
        otherPartyE2eeEnabled = users[0].userData.e2eeEnabled!;
        e2eeStatusNotifier.value = widget.myInformation.e2eeEnabled == true &&
            users[0].userData.e2eeEnabled == true;

        initializeScrolling(function: () async {
          await messageCubit.getMessages(receiverPublicKey: userPublicKey);
        });

        if (users.isNotEmpty && users[0].userData.publicKey != null) {
          messageCubit.listenMessages(
              decryptMessage: e2eeStatusNotifier.value,
              conversationId: widget.conversation.id,
              otherPartyPublicKey: userPublicKey);
        }
      } else {
        messageCubit.helperClass =
            messageCubit.helperClass.copyWith(conversationId: widget.conversation.id);

        initializeScrolling(function: () async {
          await messageCubit.getMessages(receiverPublicKey: BigInt.zero);
        });

        messageCubit.listenMessages(
            decryptMessage: e2eeStatusNotifier.value,
            conversationId: widget.conversation.id,
            otherPartyPublicKey: BigInt.zero);
      }
    });

    super.initState();
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
        encryptMessage: e2eeStatusNotifier.value,
        recieverPublicKey: BigInt.parse(users[0].userData.publicKey!),
        message: SendMessageHelper(
            conversationId: widget.conversation.id,
            isGroup: widget.conversation.isGroup,
            senderId: '',
            messageText: message,
            receiverId: users[0].userData.id));
  }

  readMessagesByConversation() async {
    await messageCubit.readMessagesByConversation(
        helper: ReadMessagesHelper(
            userId: widget.myInformation.id, conversationId: conversationId));
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

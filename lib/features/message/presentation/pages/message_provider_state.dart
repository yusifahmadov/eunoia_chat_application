import 'package:eunoia_chat_application/core/mixins/page_scrolling_mixin.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/read_messages_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/send_message_helper.dart';
import 'package:eunoia_chat_application/features/message/presentation/cubit/message_cubit.dart';
import 'package:eunoia_chat_application/features/message/presentation/pages/message_page.dart';
import 'package:eunoia_chat_application/features/message/presentation/pages/message_provider.dart';
import 'package:eunoia_chat_application/features/user/presentation/cubit/user_cubit.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';

class MessageProviderWidget extends StatefulWidget {
  const MessageProviderWidget({
    super.key,
    required this.userId,
    required this.conversationId,
  });

  final String userId;
  final int? conversationId;
  @override
  State<MessageProviderWidget> createState() => MessageProviderState();
}

class MessageProviderState extends State<MessageProviderWidget> with PageScrollingMixin {
  final messageCubit = getIt<MessageCubit>();
  final userCubit = getIt<UserCubit>();

  final messageController = TextEditingController();
  final focusNode = FocusNode();
  int conversationId = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      (await userCubit.getUser(id: widget.userId));
    });

    messageCubit.helperClass =
        messageCubit.helperClass.copyWith(conversationId: widget.conversationId);

    initializeScrolling(function: () async {
      await messageCubit.getMessages();
    });

    messageCubit.listenMessages(conversationId: conversationId);
    // readMessagesByConversation();
    super.initState();
  }

  Future<void> sendMessage({required String message}) async {
    if (message == '') return;
    await messageCubit.sendMessage(
        message: SendMessageHelper(senderId: '', messageText: message));
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

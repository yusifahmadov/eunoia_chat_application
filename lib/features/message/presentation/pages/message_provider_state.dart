import 'package:eunoia_chat_application/core/mixins/page_scrolling_mixin.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/conversation.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/send_message_helper.dart';
import 'package:eunoia_chat_application/features/message/presentation/cubit/message_cubit.dart';
import 'package:eunoia_chat_application/features/message/presentation/pages/message_page.dart';
import 'package:eunoia_chat_application/features/message/presentation/pages/message_provider.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';

class MessageProviderWidget extends StatefulWidget {
  const MessageProviderWidget({super.key, required this.conversation});

  final Conversation conversation;

  @override
  State<MessageProviderWidget> createState() => MessageProviderState();
}

class MessageProviderState extends State<MessageProviderWidget> with PageScrollingMixin {
  final messageCubit = getIt<MessageCubit>();
  final messageController = TextEditingController();
  final focusNode = FocusNode();
  @override
  void initState() {
    messageCubit.helperClass =
        messageCubit.helperClass.copyWith(conversationId: widget.conversation.id);
    initializeScrolling(function: () async {
      messageCubit.getMessages();
    });
    messageCubit.listenMessages(conversationId: widget.conversation.id);
    super.initState();
  }

  Future<void> sendMessage({required String message}) async {
    if (message == '') return;
    await messageCubit.sendMessage(
        message: SendMessageHelper(
            senderId: '', conversationId: widget.conversation.id, messageText: message));
  }

  @override
  Widget build(BuildContext context) {
    return MessageProvider(
      state: this,
      child: const MessagePage(),
    );
  }
}

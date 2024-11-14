import 'package:flutter/material.dart';

import '../../../../core/mixins/page_scrolling_mixin.dart';
import '../../../../injection.dart';
import '../../../user/domain/entities/user.dart';
import '../../../user/presentation/cubit/user_cubit.dart';
import '../../domain/entities/helper/read_messages_helper.dart';
import '../../domain/entities/helper/send_message_helper.dart';
import '../cubit/message_cubit.dart';
import 'message_page.dart';
import 'message_provider.dart';

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
  BigInt userPublicKey = BigInt.zero;
  int conversationId = 0;
  List<User> users = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (widget.conversationId != null) {
        users = (await userCubit.getUser(conversationId: widget.conversationId!));
        userPublicKey = BigInt.parse(users[0].publicKey ?? '0');
        messageCubit.helperClass =
            messageCubit.helperClass.copyWith(conversationId: widget.conversationId);

        initializeScrolling(function: () async {
          await messageCubit.getMessages(receiverPublicKey: userPublicKey);
        });

        if (users.isNotEmpty && users[0].publicKey != null) {
          messageCubit.listenMessages(
              conversationId: conversationId, otherPartyPublicKey: userPublicKey);
        }
      }
    });

    // readMessagesByConversation();
    super.initState();
  }

  Future<void> sendMessage({
    required String message,
  }) async {
    if (message == '' || users[0].publicKey == null) return;
    await messageCubit.sendMessage(
        recieverPublicKey: BigInt.parse(users[0].publicKey!),
        message: SendMessageHelper(
            senderId: '', messageText: message, receiverId: users[0].id));
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

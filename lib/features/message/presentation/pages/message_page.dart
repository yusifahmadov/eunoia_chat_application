import 'package:cached_network_image/cached_network_image.dart';
import 'package:eunoia_chat_application/core/constant/empty_box.dart';
import 'package:eunoia_chat_application/core/extensions/localization_extension.dart';
import 'package:eunoia_chat_application/features/main/presentation/utility/custom_input_decoration.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/container_icon_widget.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/text_form_field.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/themed_container.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/message.dart';
import 'package:eunoia_chat_application/features/message/presentation/cubit/message_cubit.dart';
import 'package:eunoia_chat_application/features/message/presentation/pages/message_provider.dart';
import 'package:eunoia_chat_application/features/message/presentation/pages/message_provider_state.dart';
import 'package:eunoia_chat_application/features/user/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

extension _AdvancedContext on BuildContext {
  MessageProviderState get state => MessageProvider.of(this);
}

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        persistentFooterButtons: const [_Footer(), SizedBox()],
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.pop();
            },
          ),
          title: const _AppBarTitle(),
        ),
        body: CustomScrollView(
          reverse: true,
          controller: context.state.scrollController,
          slivers: const [
            _BlocBuilder(),
          ],
        ));
  }
}

class _BlocBuilder extends StatelessWidget {
  const _BlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageCubit, MessageState>(
      bloc: context.state.messageCubit,
      builder: (context, state) {
        if (context.state.messageCubit.fetchedData.isEmpty) {
          return const SliverFillRemaining(child: Center(child: Text("Mesaj yoxdur!")));
        }
        if (state is MessageError) {
          return SliverFillRemaining(child: Center(child: Text(state.message)));
        }

        return SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList.builder(
              itemCount: context.state.messageCubit.fetchedData.length,
              itemBuilder: (context, index) {
                final message = context.state.messageCubit.fetchedData[index];
                return Align(
                    alignment: message.senderId == context.state.widget.userId
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: _MessageContainer(message: message));
              }),
        );
      },
    );
  }
}

class _MessageContainer extends StatelessWidget {
  const _MessageContainer({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ThemedContainer(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: message.senderId == context.state.widget.userId
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(message.message),
      ),
    );
  }
}

class _EmptyExpanded extends StatelessWidget {
  const _EmptyExpanded({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: SizedBox(),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      bloc: context.state.userCubit,
      builder: (context, state) {
        if (state is UserDetailLoading) {
          return const CircularProgressIndicator();
        }
        if (state is UserDetailError) {
          return Text(state.message);
        } else if (state is UserDetailSuccess) {
          return Row(
            children: [
              CircleAvatar(
                child: state.users.isNotEmpty && state.users[0].profilePhoto != null
                    ? CachedNetworkImage(imageUrl: state.users[0].profilePhoto!)
                    : SvgPicture.asset(
                        'assets/icons/no-profile-picture.svg',
                      ),
              ),
              const EmptyWidthBox(width: 10),
              Text(state.users.isNotEmpty ? state.users[0].username ?? "" : ""),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
                focusNode: context.state.focusNode,
                controller: context.state.messageController,
                decoration: CustomInputDecoration(
                    context: context, hintText: context.localization?.send_message)),
          ),
          const EmptyWidthBox(width: 5),
          ContainerIconWidget(
            containerColor: Theme.of(context).colorScheme.primaryContainer,
            icon: "send-outline",
            onTap: () async {
              await context.state
                  .sendMessage(message: context.state.messageController.text)
                  .then((v) async {
                context.state.messageController.clear();
                context.state.focusNode.unfocus();
              });
            },
          ),
        ],
      ),
    );
  }
}

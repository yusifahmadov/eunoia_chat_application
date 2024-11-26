import 'package:cached_network_image/cached_network_image.dart';
import 'package:eunoia_chat_application/core/shared_preferences/shared_preferences_user_manager.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/custom_svg_icon.dart';
import 'package:eunoia_chat_application/features/message/presentation/pages/information/group_information_provider_state.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/constant/empty_box.dart';
import '../../../../core/extensions/localization_extension.dart';
import '../../../main/presentation/utility/custom_input_decoration.dart';
import '../../../main/presentation/widgets/container_icon_widget.dart';
import '../../../main/presentation/widgets/text_form_field.dart';
import '../../../main/presentation/widgets/themed_container.dart';
import '../../../user/presentation/cubit/user_cubit.dart';
import '../../domain/entities/message.dart';
import '../cubit/message_cubit.dart';
import 'message_provider.dart';
import 'message_provider_state.dart';

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
          actions: [
            !context.state.widget.conversation.isGroup
                ? const _e2eeNotifier()
                : const SizedBox(),
            context.state.widget.conversation.isGroup
                ? GestureDetector(
                    onTap: () async {
                      final String tmpUserId =
                          (await SharedPreferencesUserManager.getUser())?.user.id ?? "";
                      showMaterialModalBottomSheet(
                          context: context,
                          builder: (_) {
                            return GroupInformationProviderWidget(
                              conversation: context.state.widget.conversation,
                              userId: tmpUserId,
                            );
                          });
                    },
                    child: const CustomSvgIcon(text: 'information-circle-outline'))
                : const SizedBox(),
            const SizedBox(
              width: 20,
            ),
          ],
          title: context.state.widget.conversation.isGroup
              ? Row(
                  children: [
                    context.state.widget.conversation.groupPhoto != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: CachedNetworkImage(
                                width: 40,
                                height: 40,
                                fit: BoxFit.fill,
                                imageUrl:
                                    context.state.widget.conversation.groupPhoto ?? ""),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(context.state.widget.conversation.title?[0]
                                        .toUpperCase()[0] ??
                                    "A"),
                              ),
                            ),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(context.state.widget.conversation.title ?? ""),
                  ],
                )
              : const _AppBarTitle(),
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

class _e2eeNotifier extends StatelessWidget {
  const _e2eeNotifier({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: context.state.e2eeNotifier,
        builder: (context, child) {
          return Stack(
            children: [
              Switch(
                value: context.state.e2eeNotifier.value,
                onChanged: (value) {
                  context.state.sendEncryptionRequest();
                },
              ),
              ListenableBuilder(
                  listenable: context.state.encryptionRequestNotifier,
                  builder: (context, child) {
                    return context.state.encryptionRequestNotifier.value != null
                        ? ContainerIconWidget(
                            onTap: () {
                              if (context.state.encryptionRequestNotifier.value == null) {
                                return;
                              }
                              showAdaptiveDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (_) {
                                    return AlertDialog.adaptive(
                                      content: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Encryption request",
                                            style:
                                                Theme.of(context).textTheme.headlineLarge,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                              "Sender: ${context.state.encryptionRequestNotifier.value?.senderName}"),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                              "Receiver: ${context.state.encryptionRequestNotifier.value?.receiverName}"),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                              "End-to-end encryption offer: ${context.state.encryptionRequestNotifier.value?.e2eeOffer == true ? "Opening" : "Closing"}"),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                              "Status: ${context.state.encryptionRequestNotifier.value?.status == true ? "Accepted" : "Pending"}"),
                                        ],
                                      ),
                                      actions: const [],
                                    );
                                  });
                            },
                            icon: 'lock-open-outline',
                            containerColor: Theme.of(context).colorScheme.outlineVariant,
                          )
                        : const SizedBox();
                  }),
            ],
          );
        });
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
          return SliverFillRemaining(
              child: Center(child: Text(mainContext?.localization?.no_messages ?? "")));
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
      child: Row(
        mainAxisAlignment: message.senderId == context.state.widget.userId
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          context.state.widget.conversation.isGroup &&
                  message.senderId != context.state.widget.userId
              ? CircleAvatar(
                  child: ClipRRect(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(message.senderName?[0] ?? "A"),
                  ),
                ))
              : const SizedBox(),
          SizedBox(
            width: context.state.widget.conversation.isGroup ? 10 : 0,
          ),
          ThemedContainer(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: message.senderId == context.state.widget.userId
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(message.message),
          ),
        ],
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
      buildWhen: (previous, current) =>
          previous != current &&
          (current is UserDetailSuccess ||
              current is UserDetailLoading ||
              current is UserDetailError),
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
                child: state.users.isNotEmpty &&
                        state.users[0].userData.profilePhoto != null
                    ? CachedNetworkImage(
                        imageUrl: '${state.users[0].userData.profilePhoto}',
                        imageBuilder: (context, imageProvider) => Container(
                          width: 120.0,
                          height: 120.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image:
                                DecorationImage(image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      )
                    : SvgPicture.asset(
                        'assets/icons/no-profile-picture.svg',
                      ),
              ),
              const EmptyWidthBox(width: 10),
              Text(state.users.isNotEmpty ? state.users[0].userData.username ?? "" : ""),
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

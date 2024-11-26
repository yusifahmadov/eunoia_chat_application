import 'package:eunoia_chat_application/core/constant/constants.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/group/make_group_page_provider_state.dart';
import 'package:eunoia_chat_application/features/main/presentation/utility/custom_cached_network_image.dart';
import 'package:eunoia_chat_application/features/message/presentation/pages/message_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../core/shared_preferences/shared_preferences_user_manager.dart';
import '../../../main/presentation/widgets/custom_svg_icon.dart';
import '../cubit/conversation_cubit.dart';
import 'conversation_provider.dart';
import 'conversation_provider_state.dart';

extension _AdvancedContext on BuildContext {
  ConversationProviderState get state => ConversationProvider.of(this);
}

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              authCubit.logout();
            },
            child: Text(context.localization?.messages ?? "")),
        actions: [
          IconButton(
            icon: const CustomSvgIcon(text: 'create-outline'),
            onPressed: () async {
              await showMaterialModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  builder: (_) {
                    return MakeGroupPageProviderWidget(
                      conversationCubit: context.state.conversationCubit,
                    );
                  }).then((a) {});
            },
          ),
        ],
      ),
      body: CustomScrollView(
        controller: context.state.scrollController,
        slivers: const [
          _BlocBuilder(),
        ],
      ),
    );
  }
}

class _BlocBuilder extends StatelessWidget {
  const _BlocBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConversationCubit, ConversationState>(
      bloc: context.state.conversationCubit,
      buildWhen: (previous, current) => (current is ConversationsLoaded ||
          current is ConversationsError ||
          current is ConversationsLoading),
      builder: (context, state) {
        if (context.state.conversationCubit.fetchedData.isEmpty) {
          return const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()));
        }
        if (state is ConversationsError) {
          return SliverFillRemaining(child: Center(child: Text(state.message)));
        }

        return const _ConversationTile();
      },
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: context.state.conversationCubit.fetchedData.length,
          itemBuilder: (context, index) {
            final conversation = context.state.conversationCubit.fetchedData[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: 1),
                contentPadding: const EdgeInsets.all(0),
                tileColor: Theme.of(context).colorScheme.surface,
                leading: conversation.isGroup
                    ? conversation.groupPhoto != null
                        ? CustomCachedNetworkImage(
                            containerHeight: 50,
                            containerWidth: 50,
                            imageUrl: conversation.groupPhoto,
                          )
                        : CircleAvatar(
                            radius: 28,
                            child: Text(conversation.title![0].toUpperCase(),
                                style: Theme.of(context).textTheme.titleSmall),
                          )
                    : CustomCachedNetworkImage(
                        containerHeight: 50,
                        containerWidth: 50,
                        imageUrl: conversation.lastMessage != null
                            ? conversation.lastMessage!.otherPartyProfilePhoto
                            : conversation.otherPartyProfilePhoto,
                      ),
                title: Row(
                  children: [
                    Text(
                      conversation.title ?? "",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Spacer(),
                    Text(DateFormat("h:mm a").format(conversation.updatedAt.toLocal()),
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                subtitle: Row(
                  children: [
                    Flexible(
                      child: Text(
                        conversation.isGroup
                            ? "${conversation.lastMessage != null ? "${conversation.lastMessage?.senderName}: ${conversation.lastMessage?.message}" : ""} "
                            : conversation.lastMessage?.message ?? "",
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                onTap: () async {
                  String userId =
                      (await SharedPreferencesUserManager.getUser())?.user.id ?? "";
                  await showMaterialModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      builder: (_) {
                        return MessageProviderWidget(
                          conversation: conversation,
                          userId: userId,
                        );
                      });
                },
              ),
            );
          }),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eunoia_chat_application/core/extensions/localization_extension.dart';
import 'package:eunoia_chat_application/core/shared_preferences/shared_preferences_user_manager.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/cubit/conversation_cubit.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/conversation_provider.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/conversation_provider_state.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/custom_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

extension _AdvancedContext on BuildContext {
  ConversationProviderState get state => ConversationProvider.of(this);
}

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localization?.messages ?? ""),
        actions: [
          IconButton(
            icon: const CustomSvgIcon(text: 'create-outline'),
            onPressed: () {
              context.go('/contacts');
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
      bloc: context.state.chatCubit,
      builder: (context, state) {
        if (state is ConversationsLoading) {
          return const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()));
        }
        if (state is ConversationsError) {
          return SliverFillRemaining(child: Center(child: Text(state.message)));
        }
        if (state is ConversationsLoaded) {}
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
          itemCount: context.state.chatCubit.fetchedData.length,
          itemBuilder: (context, index) {
            final conversation = context.state.chatCubit.fetchedData[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: 1),
                contentPadding: const EdgeInsets.all(0),
                tileColor: Theme.of(context).colorScheme.surface,
                leading: CircleAvatar(
                  radius: 30,
                  child: conversation.senderProfilePhoto != null
                      ? CachedNetworkImage(imageUrl: conversation.senderProfilePhoto!)
                      : SvgPicture.asset(
                          'assets/icons/no-profile-picture.svg',
                        ),
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
                        conversation.lastMessage?.message ?? "",
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                onTap: () async {
                  context.go('/conversations/details/${conversation.id}', extra: [
                    (await SharedPreferencesUserManager.getUser())?.user.id,
                    conversation.id,
                    conversation.senderProfilePhoto
                  ]);
                },
              ),
            );
          }),
    );
  }
}

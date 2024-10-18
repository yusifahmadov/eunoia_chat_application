import 'package:cached_network_image/cached_network_image.dart';
import 'package:eunoia_chat_application/core/extensions/localization_extension.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/cubit/conversation_cubit.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/conversation_provider.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/conversation_provider_state.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/custom_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
      ),
      body: CustomScrollView(
        slivers: [
          BlocBuilder<ConversationCubit, ConversationState>(
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
              return SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList.builder(
                    itemCount: context.state.chatCubit.fetchedData.length,
                    itemBuilder: (context, index) {
                      final conversation = context.state.chatCubit.fetchedData[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: conversation.senderProfilePhoto != null
                                ? CachedNetworkImage(
                                    imageUrl: conversation.senderProfilePhoto!)
                                : SvgPicture.asset(
                                    'assets/icons/no-profile-picture.svg',
                                  ),
                          ),
                          title: Text(
                            conversation.title,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          subtitle: Text(
                            conversation.lastMessage?.message ?? "",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          trailing: const CustomSvgIcon(text: 'arrow-redo-outline'),
                          onTap: () {},
                        ),
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}

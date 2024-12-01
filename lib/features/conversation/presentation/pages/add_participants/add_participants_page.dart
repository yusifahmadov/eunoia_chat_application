import 'package:eunoia_chat_application/core/extensions/localization_extension.dart';
import 'package:eunoia_chat_application/features/contact/presentation/cubit/contact_cubit.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/add_participants/add_participants_provider.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/add_participants/add_participants_provider_state.dart';
import 'package:eunoia_chat_application/features/main/presentation/utility/custom_cached_network_image.dart';
import 'package:eunoia_chat_application/features/main/presentation/utility/custom_input_decoration.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/custom_svg_icon.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/text_form_field.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/conversation_participant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension _AdvancedContext on BuildContext {
  AddParticipantsProviderState get state => AddParticipantsProvider.of(this);
}

class AddParticipantsPage extends StatelessWidget {
  const AddParticipantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Participants'),
        actions: [
          GestureDetector(
            onTap: () {
              context.state.addParticipants();
            },
            child: Text(
              "Add",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: context.state.participants,
          builder: (context, value, child) {
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  sliver: SliverAppBar(
                    automaticallyImplyLeading: false,
                    centerTitle: true,
                    stretch: true,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: CustomTextField(
                        onChanged: (value) async {
                          context.state.search(
                            onChanged: () async {
                              context.state.searchContacts(query: value);
                            },
                          );
                        },
                        decoration: CustomInputDecoration(
                            context: context, hintText: context.localization?.search),
                      ),
                    ),
                  ),
                ),
                BlocBuilder<ContactCubit, ContactState>(
                  bloc: context.state.contactCubit,
                  buildWhen: (previous, current) =>
                      previous != current &&
                      (current is ContactInitial ||
                          current is ContactsLoaded ||
                          current is ContactsLoading ||
                          current is ContactsError),
                  builder: (context, state) {
                    if (context.state.contactCubit.fetchedData.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Center(child: Text(context.localization?.search ?? "")),
                      );
                    }

                    return SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      sliver: SliverList.builder(
                          itemCount: context.state.contactCubit.fetchedData.length,
                          itemBuilder: (context, index) {
                            final contact = context.state.contactCubit.fetchedData[index];

                            return CheckboxListTile(
                              onChanged: (value) {
                                context.state.updateParticipantStream(
                                    user: ConversationParticipant(
                                        id: contact.id,
                                        username: contact.username ?? "",
                                        photo: contact.profilePhoto,
                                        name: contact.name ?? "",
                                        isAdmin: false,
                                        createdAt: contact.createdAt ?? DateTime.now()));
                              },
                              value: context.state.participants.contains(contact),
                              tileColor: Theme.of(context).colorScheme.surface,
                              title: Row(
                                children: [
                                  CustomCachedNetworkImage(
                                      containerHeight: 50,
                                      containerWidth: 50,
                                      imageUrl: contact.profilePhoto ?? ""),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          context.state.contactCubit.fetchedData[index]
                                                  .username ??
                                              "",
                                          style:
                                              Theme.of(context).textTheme.headlineLarge),
                                      Text(
                                          context.state.contactCubit.fetchedData[index]
                                                      .bio !=
                                                  null
                                              ? '${context.state.contactCubit.fetchedData[index].bio?.substring(0, 20)}...'
                                              : '',
                                          style: Theme.of(context).textTheme.bodyMedium),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  },
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50,
                  ),
                ),
                SliverFillRemaining(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: context.state.participants.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.outlineVariant,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Text(context.state.participants[index].username),
                                    GestureDetector(
                                        onTap: () {
                                          context.state.updateParticipantStream(
                                              user: context.state.participants[index]);
                                        },
                                        child: const CustomSvgIcon(text: 'close-outline'))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

import 'package:eunoia_chat_application/core/constant/constants.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/cubit/conversation_cubit.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/add_participants/add_participants_provider_state.dart';
import 'package:eunoia_chat_application/features/main/presentation/utility/custom_cached_network_image.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/custom_button.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/custom_svg_icon.dart';
import 'package:eunoia_chat_application/features/message/presentation/pages/information/group_information_provider.dart';
import 'package:eunoia_chat_application/features/message/presentation/pages/information/group_information_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

extension _AdvancedContext on BuildContext {
  GroupInformationProviderState get state => GroupInformationProvider.of(this);
}

class GroupInformationPage extends StatelessWidget {
  const GroupInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Information'),
      ),
      body: BlocBuilder<ConversationCubit, ConversationState>(
        bloc: conversationCubit,
        builder: (context, state) {
          if (state is GroupDataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GroupDataError) {
            return const Center(child: Text('Error'));
          } else if (state is GroupDataLoaded) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: state.groupData.first.photo != null
                        ? Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(state.groupData.first.photo!),
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        : Text(state.groupData.first.title[0].toUpperCase()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(state.groupData.first.title),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('${state.groupData.first.participants.length} Participants'),
                  const SizedBox(
                    height: 40,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Members in this group",
                        style: Theme.of(context).textTheme.titleMedium,
                      )),
                  const SizedBox(
                    height: 6,
                  ),
                  ListTile(
                    onTap: () {
                      showMaterialModalBottomSheet(
                          context: context,
                          useRootNavigator: true,
                          builder: (_) {
                            return AddParticipantsProviderWidget(
                              updateParticipant: null,
                              conversationCubit: conversationCubit,
                              conversationId: state.groupData.first.id,
                            );
                          });
                    },
                    leading: const CustomSvgIcon(text: "person-add-outline"),
                    title: Text(
                      "Add members",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.groupData.first.participants.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            trailing: Text(
                                state.groupData.first.participants[index].isAdmin == true
                                    ? 'Admin'
                                    : 'Member'),
                            leading: CircleAvatar(
                                radius: 14,
                                child: CustomCachedNetworkImage(
                                    imageUrl:
                                        state.groupData.first.participants[index].photo,
                                    containerWidth: 40,
                                    containerHeight: 40)),
                            title: Text(state.groupData.first.participants[index].id ==
                                    context.state.widget.userId
                                ? 'You (${state.groupData.first.participants[index].name})'
                                : "${state.groupData.first.participants[index].username}  (${(state.groupData.first.participants[index].name)})"),
                          ),
                        );
                      }),
                  const Spacer(),
                  CustomTextButton(
                    onPressed: () {
                      showAdaptiveDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog.adaptive(
                              title: const Text("Do you want to leave this group?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel")),
                                TextButton(
                                    onPressed: () {
                                      context.state.leaveGroup();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Leave")),
                              ],
                            );
                          });
                    },
                    text: 'Leave group',
                    maxSize: true,
                    color: Theme.of(context).colorScheme.errorContainer,
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

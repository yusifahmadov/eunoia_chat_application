import 'package:eunoia_chat_application/features/conversation/presentation/pages/add_participants/add_participants_provider_state.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/group/make_group_page_provider.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/group/make_group_page_provider_state.dart';
import 'package:eunoia_chat_application/features/main/presentation/utility/custom_input_decoration.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/custom_svg_icon.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/text_form_field.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/themed_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

extension _AdvancedContext on BuildContext {
  MakeGroupPageProviderState get state => MakeGroupPageProvider.of(this);
}

class MakeGroupPage extends StatelessWidget {
  const MakeGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !kIsWeb,
        title: const Text('New Group'),
        actions: [
          GestureDetector(
            onTap: () {
              context.state.makeGroupConversation();
            },
            child: Text(
              "Create",
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: context.state.formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  context.state.pickImage();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: ValueListenableBuilder(
                      valueListenable: context.state.imageNotifier,
                      builder: (context, value, child) {
                        return value != null
                            ? Image.file(
                                value,
                                fit: BoxFit.fill,
                                width: 100,
                                height: 100,
                              )
                            : SvgPicture.asset(
                                'assets/icons/placeholder.svg',
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              );
                      }),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                validatorF: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "Group name cannot be empty";
                  }
                  return null;
                },
                onChanged: (value) {
                  context.state.makeGroupConversationHelper =
                      context.state.makeGroupConversationHelper.copyWith(title: value);
                },
                decoration:
                    CustomInputDecoration(context: context, hintText: 'Group name'),
              ),
              const SizedBox(
                height: 40,
              ),
              ListTile(
                onTap: () {
                  kIsWeb
                      ? showGeneralDialog(
                          context: context,
                          barrierLabel: "Barrier",
                          barrierDismissible: true,
                          useRootNavigator: true,
                          barrierColor: Colors.black.withOpacity(0.5),
                          transitionDuration: const Duration(milliseconds: 700),
                          pageBuilder: (_, animation1, animation2) {
                            return Center(
                              child: ThemedContainer(
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: MediaQuery.of(context).size.width * 0.5,
                                child: AddParticipantsProviderWidget(
                                  updateParticipant: context.state.updateParticipant,
                                ),
                              ),
                            );
                          })
                      : showMaterialModalBottomSheet(
                          context: context,
                          useRootNavigator: true,
                          builder: (_) {
                            return AddParticipantsProviderWidget(
                              updateParticipant: context.state.updateParticipant,
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
              ValueListenableBuilder(
                  valueListenable: context.state.participants,
                  builder: (context, value, child) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: context.state.participants.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              title: Text(context.state.participants[index].username),
                              trailing: GestureDetector(
                                onTap: () {
                                  context.state.removeParticipant(
                                      user: context.state.participants[index]);
                                },
                                child: const CustomSvgIcon(text: 'close-outline'),
                              ),
                            ),
                          );
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}

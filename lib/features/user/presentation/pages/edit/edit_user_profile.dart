import 'package:eunoia_chat_application/core/extensions/localization_extension.dart';
import 'package:eunoia_chat_application/features/main/presentation/utility/custom_input_decoration.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/custom_button.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/text_form_field.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/edit/edit_user_provider.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/edit/edit_user_provider_state.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';

extension _AdvancedContext on BuildContext {
  EditUserProviderState get state => EditUserProvider.of(this);
}

class EditUserProfile extends StatelessWidget {
  const EditUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit User Profile'),
          actions: [
            GestureDetector(
              onTap: () {
                context.state.updateUserInformation();
              },
              child: Text(
                context.localization?.save ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: context.state.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                    validatorF: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Name cannot be empty';
                      }
                      return null;
                    },
                    controller: context.state.nameController,
                    decoration:
                        CustomInputDecoration(context: context, hintText: 'Name')),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    'Enter your name and add an optional profile photo.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: context.state.bioController,
                    decoration: CustomInputDecoration(
                      context: context,
                      hintText: 'Bio',
                    )),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text('You can add a bio to tell others more about yourself.',
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    controller: context.state.emailController,
                    readOnly: true,
                    decoration: CustomInputDecoration(
                      context: context,
                      hintText: 'Email',
                    )),
                const Spacer(),
                CustomTextButton(
                    maxSize: true,
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Theme.of(context).colorScheme.onErrorContainer),
                    color: Theme.of(context).colorScheme.errorContainer,
                    onPressed: () {},
                    text: mainContext?.localization?.logout ?? "")
              ],
            ),
          ),
        ),
      ),
    );
  }
}

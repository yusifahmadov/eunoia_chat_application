import 'package:eunoia_chat_application/features/user/domain/entities/helper/update_user_information_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/user.dart';
import 'package:eunoia_chat_application/features/user/presentation/cubit/user_cubit.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/edit/edit_user_profile.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/edit/edit_user_provider.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditUserProviderWidget extends StatefulWidget {
  const EditUserProviderWidget({super.key, required this.user, required this.userCubit});
  final User user;
  final UserCubit userCubit;
  @override
  State<EditUserProviderWidget> createState() => EditUserProviderState();
}

class EditUserProviderState extends State<EditUserProviderWidget> {
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    nameController.text = widget.user.name ?? "";
    bioController.text = widget.user.bio ?? "";

    emailController.text = widget.user.email ?? "";
    super.initState();
  }

  updateUserInformation() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    widget.userCubit.updateUserInformation(
        whenSuccess: () {
          kIsWeb ? mainContext?.go('/home') : context.pop();

          widget.userCubit.getCurrentUserInformation();
        },
        helper: UpdateUserInformationHelper(
            bio: bioController.text, name: nameController.text));
  }

  @override
  Widget build(BuildContext context) {
    return EditUserProvider(state: this, child: const EditUserProfile());
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    emailController.dispose();
    super.dispose();
  }
}

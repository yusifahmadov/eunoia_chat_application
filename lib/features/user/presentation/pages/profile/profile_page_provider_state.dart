import 'dart:io';

import 'package:eunoia_chat_application/features/user/domain/entities/helper/upload_user_profile_photo_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../injection.dart';
import '../../cubit/user_cubit.dart';
import 'profile_page.dart';
import 'profile_page_provider.dart';

class ProfilePageProviderWidget extends StatefulWidget {
  const ProfilePageProviderWidget({super.key});

  @override
  State<ProfilePageProviderWidget> createState() => ProfilePageProviderState();
}

class ProfilePageProviderState extends State<ProfilePageProviderWidget> {
  final userCubit = getIt<UserCubit>();
  UploadUserProfilePhotoHelper uploadUserProfilePhotoHelper =
      UploadUserProfilePhotoHelper(
          file: File(
            '',
          ),
          fileName: '');

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await userCubit.getCurrentUserInformation();
    });
    super.initState();
  }

  updateProfilePhoto() async {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (file != null) {
      await userCubit.updateUserProfilePhoto(
          body: UploadUserProfilePhotoHelper(
              file: File(file.files.single.path!), fileName: file.files.single.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProfilePageProvider(state: this, child: const ProfilePage());
  }
}

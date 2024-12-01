import 'dart:io';

import 'package:eunoia_chat_application/core/shared_preferences/custom_shared_preferences.dart';
import 'package:eunoia_chat_application/core/shared_preferences/shared_preferences_user_manager.dart';
import 'package:eunoia_chat_application/features/user/data/models/auth_response_model.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/helper/upload_user_profile_photo_helper.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/user.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
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
  final ValueNotifier<File?> profilePhotoNotifier = ValueNotifier(null);
  final ValueNotifier<bool> e2eeStatusNotifier = ValueNotifier(false);

  UploadUserProfilePhotoHelper uploadUserProfilePhotoHelper =
      UploadUserProfilePhotoHelper(fileBytes: [], fileName: '');

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final User? user = await userCubit.getCurrentUserInformation();
      if (user != null) {
        e2eeStatusNotifier.value = user.e2eeEnabled!;
      }
    });
    super.initState();
  }

  updateProfilePhoto() async {
    final file = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image,
    );
    if (file != null) {
      await userCubit.updateUserProfilePhoto(
          body: UploadUserProfilePhotoHelper(
              fileBytes: file.files.first.bytes!, fileName: file.files.single.name),
          whenSuccess: () async {
            if (kIsWeb) {
              userCubit.getCurrentUserInformation();
            } else {
              profilePhotoNotifier.value = File(file.files.single.path!);
            }
          });
    }
  }

  setE2eeStatus(bool status) async {
    await userCubit.setE2eeStatus(
      status: status,
      whenSuccess: () async {
        e2eeStatusNotifier.value = status;

        /// Edit shared preferences e2ee status

        AuthResponseModel? authResponse = (await SharedPreferencesUserManager.getUser());

        if (authResponse != null) {
          authResponse = authResponse.copyWith(
              user: authResponse.user.copyWith(e2eeEnabled: status));

          await CustomSharedPreferences.saveUser('user', authResponse!);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProfilePageProvider(state: this, child: const ProfilePage());
  }
}

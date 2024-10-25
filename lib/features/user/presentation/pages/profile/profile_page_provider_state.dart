import 'package:eunoia_chat_application/features/user/presentation/cubit/user_cubit.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/profile/profile_page.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/profile/profile_page_provider.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';

class ProfilePageProviderWidget extends StatefulWidget {
  const ProfilePageProviderWidget({super.key});

  @override
  State<ProfilePageProviderWidget> createState() => ProfilePageProviderState();
}

class ProfilePageProviderState extends State<ProfilePageProviderWidget> {
  final userCubit = getIt<UserCubit>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await userCubit.getCurrentUserInformation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProfilePageProvider(state: this, child: const ProfilePage());
  }
}

import 'package:eunoia_chat_application/core/constant/constants.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              authCubit.logout();
            },
            child: const Text('Profile')),
      ),
    );
  }
}

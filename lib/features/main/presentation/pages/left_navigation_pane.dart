import 'package:eunoia_chat_application/features/contact/presentation/pages/contact_provider_state.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/conversation_provider_state.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/profile/profile_page_provider_state.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/extensions/localization_extension.dart';

class LeftNavigationPane extends StatefulWidget {
  const LeftNavigationPane({super.key});

  @override
  State<LeftNavigationPane> createState() => _LeftNavigationPaneState();
}

class _LeftNavigationPaneState extends State<LeftNavigationPane> {
  int currentIndex = 0;
  List<Widget> pages = [
    const ConversationProviderWidget(),
    const ContactProviderWidget(),
    const ProfilePageProviderWidget()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  BottomNavigationBar _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
            if (index != 0) context.go('/home');
          });
        },
        currentIndex: currentIndex,
        elevation: 5,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        items: [
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              "assets/icons/chatbubbles.svg",
              width: 25,
              height: 25,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: mainContext?.localization?.messages,
            icon: SvgPicture.asset(
              "assets/icons/chatbubbles.svg",
              width: 25,
              height: 25,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
          ),
          BottomNavigationBarItem(
            label: mainContext?.localization?.search,
            activeIcon: SvgPicture.asset(
              "assets/icons/person.svg",
              width: 25,
              height: 25,
              color: Theme.of(context).colorScheme.primary,
            ),
            icon: SvgPicture.asset(
              "assets/icons/person.svg",
              width: 25,
              height: 25,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
          ),
          BottomNavigationBarItem(
            label: mainContext?.localization?.settings,
            activeIcon: SvgPicture.asset(
              "assets/icons/cog-outline.svg",
              width: 25,
              height: 25,
              color: Theme.of(context).colorScheme.primary,
            ),
            icon: SvgPicture.asset(
              "assets/icons/cog-outline.svg",
              width: 25,
              height: 25,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
          ),
        ]);
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/extensions/localization_extension.dart';
import '../../../../injection.dart';

class MainPageView extends StatefulWidget {
  const MainPageView(
      {super.key,
      required this.body,
      required this.selectedIndex,
      required this.onDestinationSelected});
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: _bottomNavigationBar(), body: widget.body);
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
        onTap: (index) {
          widget.onDestinationSelected(index);
        },
        currentIndex: widget.selectedIndex,
        elevation: 5,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        items: [
          BottomNavigationBarItem(
            activeIcon: LottieBuilder.asset(
              'assets/lottie/chat-bubble-filled.json',
              width: 30,
              animate: true,
              height: 30,
              fit: BoxFit.cover,
            ),
            label: mainContext?.localization?.messages,
            icon: LottieBuilder.asset(
              'assets/lottie/chat-bubble.json',
              width: 30,
              animate: false,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
          BottomNavigationBarItem(
            label: mainContext?.localization?.search,
            activeIcon: LottieBuilder.asset(
              'assets/lottie/avatar-filled-2.json',
              width: 30,
              animate: true,
              height: 30,
              fit: BoxFit.cover,
            ),
            icon: LottieBuilder.asset(
              'assets/lottie/avatar.json',
              width: 30,
              animate: false,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
          BottomNavigationBarItem(
            label: mainContext?.localization?.settings,
            activeIcon: LottieBuilder.asset(
              'assets/lottie/setting-2.json',
              width: 30,
              animate: true,
              height: 30,
              fit: BoxFit.cover,
            ),
            icon: LottieBuilder.asset(
              'assets/lottie/setting-nofill.json',
              width: 30,
              animate: false,
              height: 30,
              fit: BoxFit.cover,
            ),
          ),
        ]);
  }
}

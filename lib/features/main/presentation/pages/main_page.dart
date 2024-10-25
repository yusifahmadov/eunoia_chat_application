import 'package:eunoia_chat_application/core/extensions/localization_extension.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

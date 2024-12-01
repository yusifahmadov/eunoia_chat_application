import 'package:eunoia_chat_application/features/main/presentation/pages/left_navigation_pane.dart';
import 'package:flutter/material.dart';

class MainPageViewWeb extends StatefulWidget {
  const MainPageViewWeb(
      {required this.body,
      super.key,
      required this.onDestinationSelected,
      required this.selectedIndex});
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  State<MainPageViewWeb> createState() => _MainPageViewWebState();
}

class _MainPageViewWebState extends State<MainPageViewWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        const Expanded(
          child: Column(
            children: [
              Expanded(child: LeftNavigationPane()),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: widget.body,
        ),
      ],
    ));
  }
}

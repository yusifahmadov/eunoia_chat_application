import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AnimatedSwitch extends StatefulWidget {
  AnimatedSwitch({required this.onTap, required this.isEnabled, super.key});
  final onTap;
  bool isEnabled;

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedSwitchState createState() => _AnimatedSwitchState();
}

class _AnimatedSwitchState extends State<AnimatedSwitch> {
  final animationDuration = const Duration(milliseconds: 200);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isEnabled = !widget.isEnabled;
          widget.onTap();
        });
      },
      child: AnimatedContainer(
        height: 40,
        width: 70,
        duration: animationDuration,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: widget.isEnabled ? const Color(0xff565671) : const Color(0xff989fd5),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: const [],
        ),
        child: AnimatedAlign(
          duration: animationDuration,
          alignment: widget.isEnabled ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

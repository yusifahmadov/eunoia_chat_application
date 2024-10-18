import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgIcon extends StatelessWidget {
  const CustomSvgIcon(
      {required this.text, super.key, this.height, this.width, this.color});
  final String text;
  final double? height;
  final double? width;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$text.svg',
      width: width ?? 20,
      height: height ?? 20,
      color: color ?? Theme.of(context).colorScheme.onPrimaryContainer,
    );
  }
}

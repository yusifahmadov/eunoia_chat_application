import 'package:eunoia_chat_application/features/main/presentation/utility/custom_border_radius.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/custom_svg_icon.dart';
import 'package:flutter/material.dart';

class ContainerIconWidget extends StatelessWidget {
  const ContainerIconWidget({
    required this.icon,
    super.key,
    this.onTap,
    this.height,
    this.width,
    this.iconColor,
    this.containerColor,
  });
  final String icon;
  final Function()? onTap;
  final double? width;
  final double? height;
  final Color? iconColor;
  final Color? containerColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 35,
        height: height ?? 35,
        decoration: BoxDecoration(
          borderRadius: CustomBorderRadius.radius8(),
          color: containerColor ?? Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: Center(
          child: CustomSvgIcon(
            color: iconColor,
            text: icon,
            width: width == null ? 20 : 15,
            height: height == null ? 20 : 15,
          ),
        ),
      ),
    );
  }
}

import 'package:eunoia_chat_application/core/constant/constants.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.onPressed,
    required this.text,
    super.key,
    this.width,
    this.hasBorderRadius = true,
    this.maxSize = false,
    this.color,
    this.textStyle,
  });
  final void Function()? onPressed;
  final Color? color;
  final String text;
  final TextStyle? textStyle;
  final double? width;
  final bool maxSize;
  final bool hasBorderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxSize == true ? double.infinity : width,
      child: MaterialButton(
        minWidth: 100,
        highlightElevation: 0,
        disabledElevation: 0,
        shape: hasBorderRadius
            ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
            : null,
        highlightColor: Colors.transparent,
        splashColor: Colors.black54,
        onPressed: onPressed,
        color: mainCubit.themeValue == false
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.primary,
        elevation: 0,
        padding: const EdgeInsets.all(14),
        hoverElevation: 0,
        focusElevation: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
          child: Text(
            text,
            style: textStyle ??
                Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}

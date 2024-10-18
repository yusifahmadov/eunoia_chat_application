import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    required this.onPressed,
    required this.text,
    super.key,
    this.color,
    this.style,
  });

  final Color? color;
  final String text;
  final void Function()? onPressed;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color ?? Theme.of(context).colorScheme.primary,
      elevation: 0,
      child: Center(
        child: Text(
          text,
          style: style ??
              Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}

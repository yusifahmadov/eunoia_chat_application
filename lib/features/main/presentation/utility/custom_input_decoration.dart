import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_border_radius.dart';

typedef FutureCallBack = Future<void> Function();

class CustomInputDecoration extends InputDecoration {
  CustomInputDecoration(
      {required context,
      required hintText,
      bool? clearButton,
      Color? iconColor,
      bool? obscured,
      Color? fillColor,
      bool? obscureChecker,
      FutureCallBack? onTap,
      FutureCallBack? onObscureChange,
      TextStyle? hintStyle,
      super.prefixText,
      super.suffixText,
      String? icon,
      void Function()? onIconTap,
      BorderRadius? borderRadius,
      bool? isSearchField})
      : super(
            hintStyle: hintStyle ?? Theme.of(context).textTheme.bodyMedium!.copyWith(),
            hintText: hintText,
            filled: true,
            isDense: true,
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error.withOpacity(0.5),
                    width: 0.5,
                    strokeAlign: 0.0,
                    style: BorderStyle.solid),
                borderRadius: borderRadius ?? CustomBorderRadius.radius8()),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error.withOpacity(0.5),
                    width: 0.5,
                    strokeAlign: 0.0,
                    style: BorderStyle.solid),
                borderRadius: borderRadius ?? CustomBorderRadius.radius8()),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black.withOpacity(0.5),
                    width: 0.15,
                    strokeAlign: 0.0,
                    style: BorderStyle.solid),
                borderRadius: borderRadius ?? CustomBorderRadius.radius8()),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black.withOpacity(0.5),
                    width: 0.15,
                    strokeAlign: 0.0,
                    style: BorderStyle.solid),
                borderRadius: borderRadius ?? CustomBorderRadius.radius8()),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black.withOpacity(0.5),
                    width: 0.15,
                    strokeAlign: 0.0,
                    style: BorderStyle.solid),
                borderRadius: borderRadius ?? CustomBorderRadius.radius8()),
            contentPadding:
                clearButton != null || (isSearchField != false && isSearchField != null)
                    ? const EdgeInsets.fromLTRB(8, 0, 0, 0)
                    : obscureChecker == true
                        ? const EdgeInsets.fromLTRB(0, 20, 0, 0)
                        : null,
            errorMaxLines: 6,
            labelStyle: Theme.of(context).textTheme.bodyLarge,
            hoverColor: Colors.transparent,
            suffixIconConstraints: const BoxConstraints(maxWidth: 38),
            suffixIcon: icon != null
                ? GestureDetector(
                    onTap: onIconTap,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: SvgPicture.asset(
                          "assets/icons/$icon.svg",
                          height: 20,
                          width: 20,
                          color: iconColor ??
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        )),
                  )
                : null);
}

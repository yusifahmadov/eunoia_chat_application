import 'package:flutter/material.dart';

import '../utility/custom_input_decoration.dart';
import 'text_form_field.dart';

class CustomAdvancedTextField {
  static SizedBox nonSearchTextField(
      {required BuildContext context,
      TextEditingController? textEditingController,
      void Function(String)? onFieldSubmitted,
      required String hintText,
      TextStyle? hintStyle,
      TextStyle? textStyle,
      bool? numberInputType,
      dynamic Function(String)? onChanged,
      required Future<void> Function() onTap,
      double width = 220}) {
    return SizedBox(
      width: width,
      height: 26,
      child: CustomTextField(
          onChanged: onChanged,
          numberInputType: numberInputType ?? false,
          controller: textEditingController,
          onFieldSubmitted: onFieldSubmitted,
          decoration: CustomInputDecoration(
              context: context,
              hintText: hintText,
              isSearchField: false,
              hintStyle: hintStyle ??
                  Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
              clearButton: true,
              onTap: () async {
                if (textEditingController != null) {
                  textEditingController.clear();
                }
                onTap();
              }),
          textStyle: textStyle ?? Theme.of(context).textTheme.bodyMedium),
    );
  }

  static Widget searchableTextField(
      {required BuildContext context,
      void Function(String)? onFieldSubmitted,
      Function(String)? onChanged,
      required String hintText,
      BorderRadius? borderRadius,
      bool? numberInputType,
      double width = 320,
      TextEditingController? controller}) {
    return CustomTextField(
        controller: controller,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        numberInputType: numberInputType,
        decoration: CustomInputDecoration(
          context: context,
          hintText: hintText,
          borderRadius: borderRadius,
        ),
        textStyle: Theme.of(context).textTheme.bodyMedium);
  }
}

class SearchableTextField extends StatelessWidget {
  const SearchableTextField(
      {super.key,
      this.onFieldSubmitted,
      required this.hintText,
      required this.context,
      this.borderRadius,
      this.onChanged,
      this.numberInputType,
      this.controller});
  final BuildContext context;
  final void Function(String)? onFieldSubmitted;
  final String hintText;
  final BorderRadius? borderRadius;
  final bool? numberInputType;
  final Function(String)? onChanged;
  final double width = 320;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
          controller: controller,
          onFieldSubmitted: onFieldSubmitted,
          numberInputType: numberInputType,
          onChanged: onChanged,
          decoration: CustomInputDecoration(
            context: context,
            hintText: hintText,
            borderRadius: borderRadius,
          ),
          textStyle: Theme.of(context).textTheme.bodyMedium),
    );
  }
}

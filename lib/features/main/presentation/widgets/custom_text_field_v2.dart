import 'package:flutter/material.dart';

class CustomTextFieldWithTopPlaceHolder extends StatelessWidget {
  const CustomTextFieldWithTopPlaceHolder(
      {required this.customTextField, required this.text, super.key});
  final String? text;
  final Widget customTextField;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text != null
            ? Text(
                text!,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            : const SizedBox(),
        SizedBox(
          height: text != null ? 10 : 0,
        ),
        customTextField,
      ],
    );
  }
}

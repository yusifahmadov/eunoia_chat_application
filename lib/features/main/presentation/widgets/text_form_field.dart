import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../injection.dart';

class CustomTextField extends TextFormField {
  final Future<void> Function()? onTap;
  @override
  final Function(String)? onChanged;

  final String? Function(String?)? validatorF;

  CustomTextField(
      {super.key,
      super.controller,
      required InputDecoration super.decoration,
      TextStyle? textStyle,
      bool? numberInputType,
      int? minLine,
      bool? obscureText,
      int? maxLine,
      super.onFieldSubmitted,
      bool? clickable,
      this.onTap,
      this.onChanged,
      bool? readOnly,
      this.validatorF})
      : super(
          onTap: onTap,
          cursorWidth: 1.5,
          mouseCursor: clickable != null ? SystemMouseCursors.click : null,
          validator: validatorF,
          obscureText: obscureText ?? false,
          keyboardType:
              numberInputType == true ? TextInputType.number : TextInputType.text,
          readOnly: readOnly ?? false,
          maxLines: maxLine ?? 1,
          inputFormatters: numberInputType == true
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                ]
              : [],
          style: textStyle ??
              Theme.of(getIt<GlobalKey<NavigatorState>>().currentContext!)
                  .textTheme
                  .bodyMedium,
          onChanged: onChanged,
        );
}

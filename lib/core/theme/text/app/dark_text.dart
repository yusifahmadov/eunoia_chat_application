import 'package:eunoia_chat_application/core/theme/text/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextThemeDark implements ITextTheme {
  TextThemeDark() {
    data = TextTheme(
      titleMedium: GoogleFonts.workSans(fontWeight: FontWeight.w400, fontSize: 16),
      titleLarge: GoogleFonts.workSans(fontWeight: FontWeight.w400, fontSize: 20),
      titleSmall: GoogleFonts.workSans(fontWeight: FontWeight.w500, fontSize: 13),
      headlineLarge: GoogleFonts.workSans(fontWeight: FontWeight.w700, fontSize: 18),
      bodyLarge: GoogleFonts.workSans(
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.workSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.workSans(
        fontSize: 13,
        fontWeight: FontWeight.w300,
      ),
    ).apply();
    fontFamily = GoogleFonts.workSans().fontFamily;
  }
  @override
  late TextTheme data;
  @override
  TextStyle? bodyText1;

  @override
  TextStyle? bodyText2;

  @override
  TextStyle? headline1;

  @override
  TextStyle? headline3;

  @override
  TextStyle? headline4;

  @override
  TextStyle? headline5;

  @override
  TextStyle? headline6;

  @override
  TextStyle? subtitle1;

  @override
  TextStyle? subtitle2;

  @override
  String? fontFamily;
}

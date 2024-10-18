import 'package:flutter/material.dart';

part './kind/dark_color.dart';
part './kind/light_color.dart';

@immutable
class AppColors {}

abstract class IColors {
  AppColors get colors;
  Color? scaffoldBackgroundColor;
  Color? appBarColor;
  Color? tabBarColor;
  Color? fillColor;
  Color? tabbarSelectedColor;
  Color? tabbarNormalColor;
  Brightness? brightness;
  Color? primary;
  ColorScheme? colorScheme;
}

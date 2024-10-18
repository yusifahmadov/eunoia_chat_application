part of '../color_manager.dart';

class DarkColors implements IColors {
  DarkColors() {
    colorScheme = const ColorScheme.dark().copyWith(
      brightness: Brightness.dark,
      primary: const Color(0xFF88C0D0),
      onPrimary: const Color(0xFF2E3440),
      primaryContainer: const Color(0xFF434C5E), // Darker shade of primary
      onPrimaryContainer: const Color(0xFFD8DEE9),
      secondary: const Color(0xFF81A1C1),
      onSecondary: const Color(0xFF2E3440),
      secondaryContainer: const Color(0xFF3B4252), // Darker shade of secondary
      onSecondaryContainer: const Color(0xFFD8DEE9),
      tertiary: const Color(0xFF5E81AC),
      onTertiary: const Color(0xFF2E3440),
      tertiaryContainer: const Color(0xFF4C566A), // Darker shade of tertiary
      onTertiaryContainer: const Color(0xFFD8DEE9),
      error: const Color(0xFFBF616A),
      onError: const Color(0xFF2E3440),
      errorContainer: const Color(0xFF934539), // Darker shade of error
      onErrorContainer: const Color(0xFFF2D7D5),
      surface: const Color(0xFF3B4252),
      onSurface: const Color(0xFFECEFF4),
      surfaceContainerHighest: const Color(0xFF4C566A), // Darker variant of surface
      onSurfaceVariant: const Color(0xFFD8DEE9),
      outline: const Color(0xFF88838F), // Lighter outline for dark mode
      outlineVariant: const Color(0xFF4C566A),
      shadow: const Color(0xFF000000),
      scrim: const Color(0xFF000000),
      inverseSurface: const Color(0xFFD8DEE9),
      onInverseSurface: const Color(0xFF2E3440),
      inversePrimary: const Color(0xFF4C566A),
      surfaceTint: const Color(0xFF88C0D0),
    );

    brightness = Brightness.dark;
  }
  @override
  final AppColors colors = AppColors();

  @override
  ColorScheme? colorScheme;

  @override
  Brightness? brightness;

  @override
  Color? appBarColor;

  @override
  Color? scaffoldBackgroundColor;

  @override
  Color? tabBarColor;

  @override
  Color? tabbarNormalColor;

  @override
  Color? tabbarSelectedColor;

  @override
  Color? primary;

  @override
  Color? fillColor;
}

part of '../color_manager.dart';

class LightColors implements IColors {
  LightColors() {
    colorScheme = const ColorScheme.light().copyWith(
      brightness: Brightness.light,
      primary: const Color(0xFF0088CC), // Classic Telegram Blue
      onPrimary: const Color(0xFFFFFFFF), // White for text/icons
      primaryContainer: const Color(0xFFD1ECF9), // Subtle light blue
      onPrimaryContainer: const Color(0xFF003348), // Dark contrast for text
      secondary: const Color(0xFF54A0FF), // Lighter vibrant blue
      onSecondary: const Color(0xFFFFFFFF), // White for text/icons
      secondaryContainer: const Color(0xFFB3DBFF), // Softer light blue
      onSecondaryContainer: const Color(0xFF002A45), // Dark contrast for containers
      tertiary: const Color(0xFF43C6A2), // Fresh minty green accent
      onTertiary: const Color(0xFFFFFFFF), // White
      tertiaryContainer: const Color(0xFFC8F7E8), // Very light green
      onTertiaryContainer: const Color(0xFF00382B), // Dark contrast for text
      error: const Color(0xFFE53935), // Standard error red
      onError: const Color(0xFFFFFFFF), // White
      errorContainer: const Color(0xFFFFE9E9), // Soft pinkish-red container
      onErrorContainer: const Color(0xFF5A1A1A), // Dark grey text
      surface: const Color(0xFFFFFFFF), // White for surfaces
      onSurface: const Color(0xFF1C1C1E), // Dark grey text
      surfaceContainerHighest: const Color(0xFFF7F9FC), // Very subtle off-white
      onSurfaceVariant: const Color(0xFF53565A), // Medium grey for subtler text
      outline: const Color(0xFFB0BEC5), // Light grey for outlines
      inverseSurface: const Color(0xFF2E3440), // Dark surface for inverse
      onInverseSurface: const Color(0xFFFFFFFF), // White for text
      inversePrimary: const Color(0xFF56C6F7), // Light Telegram Blue
      surfaceTint: const Color(0xFF0088CC), // Matches primary color
    );

    brightness = Brightness.light;
  }
  @override
  final AppColors colors = AppColors();

  @override
  ColorScheme? colorScheme;
  @override
  Color? appBarColor;

  @override
  Color? scaffoldBackgroundColor;

  @override
  Color? tabBarColor;

  @override
  Color? tabbarNormalColor;

  Color? ownRed;
  @override
  Color? tabbarSelectedColor;

  @override
  Brightness? brightness;

  @override
  Color? primary;

  @override
  Color? fillColor;
}

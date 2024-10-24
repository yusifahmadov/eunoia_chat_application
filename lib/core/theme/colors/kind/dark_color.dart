part of '../color_manager.dart';

class DarkColors implements IColors {
  DarkColors() {
    colorScheme = const ColorScheme.dark().copyWith(
      brightness: Brightness.dark,
      primary: const Color(0xFF2AABEE), // Telegram Blue
      onPrimary: const Color(0xFFFFFFFF), // White
      primaryContainer: const Color(0xFF0079C6), // Darker Telegram Blue (adjusted)
      onPrimaryContainer: const Color(0xFFFFFFFF), // White
      secondary: const Color(0xFF2AABEE), // Telegram Blue
      onSecondary: const Color(0xFFFFFFFF), // White
      secondaryContainer: const Color(0xFF0079C6), // Darker Telegram Blue (adjusted)
      onSecondaryContainer: const Color(0xFFFFFFFF), // White
      tertiary: const Color(0xFF5E81AC), // Keep this or choose a suitable accent color
      onTertiary: const Color(0xFFFFFFFF), // White
      tertiaryContainer: const Color(0xFF4C566A), // Keep this or choose a darker accent
      onTertiaryContainer: const Color(0xFFD8DEE9),
      error: const Color(0xFFE74C3C), // Telegram Red (unchanged)
      onError: const Color(0xFFFFFFFF), // White
      errorContainer: const Color(0xFF9B0000), // Darker Telegram Red (unchanged)
      onErrorContainer: const Color(0xFFFFFFFF), // White
      surface: const Color(0xFF18222D), // Telegram Dark Background (unchanged)
      onSurface: const Color(0xFFFFFFFF), // White
      surfaceContainerHighest:
          const Color(0xFF24313F), // Slightly lighter background (unchanged)
      onSurfaceVariant: const Color(0xFF808995), // Lighter grey for contrast (unchanged)
      outline: const Color(0xFF808995), // Lighter grey for outlines (unchanged)
      outlineVariant: const Color(0xFF24313F),
      shadow: const Color(0xFF000000),
      scrim: const Color(0xFF000000),
      inverseSurface: const Color(0xFFE0E0E0), // Light grey for inverse (unchanged)
      onInverseSurface: const Color(0xFF000000), // Black
      inversePrimary: const Color(0xFFA6D9F4), // Lighter Telegram Blue (adjusted)
      surfaceTint: const Color(0xFF2AABEE), // Telegram Blue
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

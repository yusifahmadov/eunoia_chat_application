part of '../color_manager.dart';

class LightColors implements IColors {
  LightColors() {
    colorScheme = const ColorScheme.light().copyWith(
      brightness: Brightness.light,
      primary: const Color(0xFF000000), // Black - Uber's primary brand color
      onPrimary: const Color(0xFFFFFFFF),
      primaryContainer: const Color(0xFFF5F5F5), // Slightly darker gray for containers
      onPrimaryContainer: const Color(0xFF000000),
      secondary: const Color(0xFF1FBAD6), // Uber's teal accent color
      onSecondary: const Color(0xFFFFFFFF),
      secondaryContainer: const Color(0xFFD1F6F4), // Light teal for containers
      onSecondaryContainer: const Color(0xFF003832),
      tertiary: const Color(0xFFAAAAAA), // Lighter gray for subtle elements
      onTertiary: const Color(0xFFFFFFFF),
      tertiaryContainer:
          const Color(0xFFF2F2F2), // Even lighter gray for tertiary containers
      onTertiaryContainer: const Color(0xFF212121),
      error: const Color(0xFFB00020),
      onError: const Color(0xFFFFFFFF),
      errorContainer: const Color(0xFFFCD5D9),
      onErrorContainer: const Color(0xFF93000A),
      surface: const Color(0xFFFFFFFF), // White background
      onSurface: const Color(0xFF212121),
      surfaceContainerHighest:
          const Color(0xFFEEEEEE), // Light gray for subtle containers
      onSurfaceVariant: const Color(0xFF424242),
      outline: const Color(0xFFBDBDBD), // Light gray outline
      outlineVariant: const Color(0xFFE0E0E0), // Even lighter gray outline
      shadow: const Color(0xFF000000),
      scrim: const Color(0xFF000000),
      inverseSurface: const Color(0xFF313033),
      onInverseSurface: const Color(0xFFF4F0F4),
      inversePrimary: const Color(0xFF616161),
      surfaceTint: const Color(0xFF000000),
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

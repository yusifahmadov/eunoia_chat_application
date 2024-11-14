import 'package:flutter/material.dart';

import '../../features/main/presentation/utility/custom_border_radius.dart';
import 'colors/color_manager.dart';
import 'text/app/dark_text.dart';
import 'text/app/light_text.dart';
import 'text/text_theme.dart';

abstract class ITheme {
  ITextTheme get textTheme;
  IColors get colors;
}

abstract class ThemeManager {
  static ThemeData craeteTheme(ITheme theme) => ThemeData(
        useMaterial3: true,
        drawerTheme: const DrawerThemeData(
          elevation: 10,
          backgroundColor: Colors.white,
          scrimColor: Colors.transparent,
          shadowColor: Colors.black,
          surfaceTintColor: Colors.transparent,
        ),
        dividerColor: theme.colors.colorScheme!.onSurface,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: theme.colors.colorScheme!.surface,
        ),
        cardTheme: CardTheme(
          color: theme.colors.colorScheme!.primaryContainer,
          elevation: 1,
        ),
        highlightColor: Colors.transparent,
        dialogTheme:
            DialogTheme(backgroundColor: theme.colors.colorScheme!.surface, elevation: 0),
        scaffoldBackgroundColor: theme.colors.colorScheme!.surface,
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateColor.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return theme.colors.colorScheme!.primary;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            }
            return null;
          }),
          side: WidgetStateBorderSide.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {}
            return BorderSide(
              width: 0,
              strokeAlign: 0,
              color: theme.colors.colorScheme!.onPrimaryContainer,
            );
          }),
        ),
        buttonTheme: const ButtonThemeData(),
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.resolveWith((state) {
            return theme.colors.colorScheme!.primary;
          }),
          thumbVisibility: const WidgetStatePropertyAll(true),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: theme.colors.colorScheme!.surface,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(
            color: theme.colors.colorScheme!.primary, // Change to your desired color
          ),
          backgroundColor: theme.colors.colorScheme!.surface,
          titleTextStyle: theme.textTheme.data.titleMedium!
              .copyWith(color: theme.colors.colorScheme!.onSurface),
        ),
        fontFamily: theme.textTheme.fontFamily,
        expansionTileTheme: ExpansionTileThemeData(
          backgroundColor: theme.colors.colorScheme!.primaryContainer,
          collapsedBackgroundColor: theme.colors.colorScheme!.primaryContainer,
        ),
        textTheme: theme.textTheme.data,
        listTileTheme: ListTileThemeData(
          tileColor: theme.colors.colorScheme!.surfaceContainerHighest,
          titleTextStyle: theme.textTheme.data.bodyMedium!
              .copyWith(color: theme.colors.colorScheme!.onPrimaryContainer),
          subtitleTextStyle: theme.textTheme.data.titleSmall!
              .copyWith(color: theme.colors.colorScheme!.onPrimaryContainer),
          shape: RoundedRectangleBorder(
            borderRadius: CustomBorderRadius.radius8(),
            side: BorderSide(
              color: Colors.black.withOpacity(0.5),
              width: 0.15,
              strokeAlign: 0,
            ),
          ),
        ),
        splashColor: Colors.transparent,
        colorScheme: theme.colors.colorScheme?.copyWith(),
      );
}

class AppThemeDark extends ITheme {
  AppThemeDark() {
    textTheme = TextThemeDark();
  }
  @override
  late final ITextTheme textTheme;

  @override
  IColors get colors => DarkColors();
}

class AppThemeLight extends ITheme {
  AppThemeLight() {
    textTheme = TextThemeLight();
  }
  @override
  late final ITextTheme textTheme;

  @override
  IColors get colors => LightColors();
}

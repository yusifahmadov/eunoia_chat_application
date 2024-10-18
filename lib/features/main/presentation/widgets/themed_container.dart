import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';

class ThemedContainer extends Container {
  ThemedContainer({
    super.key,
    super.alignment,
    super.padding,
    BoxDecoration? decoration, // Use BoxDecoration? for null safety
    super.foregroundDecoration,
    super.width,
    super.height,
    super.constraints,
    super.margin,
    super.transform,
    super.transformAlignment,
    super.clipBehavior = Clip.none,
    super.child,
  }) : super(
          decoration: decoration != null
              ? decoration.copyWith(
                  color: decoration.color ??
                      Theme.of(mainContext!).colorScheme.primaryContainer,
                ) // Merge with the theme's color
              : BoxDecoration(
                  // If no decoration is provided, create one with the theme color
                  color: Theme.of(mainContext!).colorScheme.primaryContainer,
                ),
        );
}

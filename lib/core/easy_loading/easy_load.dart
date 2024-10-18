import 'package:eunoia_chat_application/core/easy_loading/custom_animation.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EasyLoad {
  static void init() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 15.0
      ..progressColor = Theme.of(mainContext!).colorScheme.primary
      ..backgroundColor = Colors.white
      ..indicatorColor = Theme.of(mainContext!).colorScheme.primary
      ..textColor = Colors.yellow
      ..maskColor = Colors.black.withOpacity(0.6)
      ..userInteractions = false
      ..lineWidth = 2
      ..dismissOnTap = false
      ..customAnimation = CustomAnimation();
  }

  static Future<void> show() async {
    await EasyLoading.show(
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.custom,
    );
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}

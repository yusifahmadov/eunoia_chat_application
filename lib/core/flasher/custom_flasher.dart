import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

import '../../injection.dart';
import '../constant/constants.dart';

class CustomFlasher {
  // Method to show an error flash message
  static Future<void> showError(String? text, {VoidCallback? onTap}) async {
    await _showFlash(
      context: mainContext!,
      text: text ?? 'Xəta baş verdi!',
      backgroundColor: const Color(0xffdc3545),
      key: const Key('failFlash'),
      onTap: onTap,
    );
  }

  // Method to show a success flash message
  static Future<void> showSuccess(
    String? text, {
    VoidCallback? onTap,
    BuildContext? context,
  }) async {
    await _showFlash(
      context: context ?? mainContext!,
      text: text ?? 'Əməliyyat icra olundu!',
      backgroundColor: greenColor,
      key: const Key('successFlash'),
      onTap: onTap,
    );
  }

  // Private method to show a flash message
  static Future<void> _showFlash({
    required BuildContext context,
    required String text,
    required Color backgroundColor,
    required Key key,
    VoidCallback? onTap,
  }) async {
    await showFlash(
      context: context,
      duration: const Duration(seconds: 4),
      builder: (_, controller) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.topRight,
            child: Flash(
                key: key,
                dismissDirections: const [FlashDismissDirection.vertical],
                position: FlashPosition.top,
                controller: controller,
                child: FlashBar(
                  behavior: FlashBehavior.floating,
                  position: FlashPosition.top,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  dismissDirections: const [FlashDismissDirection.vertical],
                  backgroundColor: backgroundColor,
                  content: Text(
                    text
                        .replaceAll('{', '')
                        .replaceAll('}', '')
                        .replaceAll('detail', 'Xəta mesajı'),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  controller: controller,
                )),
          ),
        );
      },
    );
  }
}

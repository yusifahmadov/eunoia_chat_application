import 'package:eunoia_chat_application/features/user/presentation/pages/qr/qr_provider_state.dart';
import 'package:flutter/material.dart';

class QrProvider extends InheritedWidget {
  final QrProviderState state;
  const QrProvider({super.key, required this.state, required super.child});

  static QrProviderState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<QrProvider>();

    if (result == null) {
      throw Exception('QrProvider not found in context');
    }

    return result.state;
  }

  @override
  bool updateShouldNotify(QrProvider oldWidget) {
    return false;
  }
}

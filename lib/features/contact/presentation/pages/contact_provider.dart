import 'package:eunoia_chat_application/features/contact/presentation/pages/contact_provider_state.dart';
import 'package:flutter/material.dart';

class ContactProvider extends InheritedWidget {
  final ContactProviderState state;
  const ContactProvider({super.key, required super.child, required this.state});

  static ContactProviderState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<ContactProvider>();

    if (result == null) {
      throw Exception('ContactProvider not found in context');
    }

    return result.state;
  }

  @override
  bool updateShouldNotify(ContactProvider oldWidget) {
    return false;
  }
}

import 'package:eunoia_chat_application/features/user/presentation/pages/edit/edit_user_provider_state.dart';
import 'package:flutter/material.dart';

class EditUserProvider extends InheritedWidget {
  final EditUserProviderState state;

  const EditUserProvider({super.key, required super.child, required this.state});

  static EditUserProviderState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<EditUserProvider>();

    if (result == null) {
      throw Exception('EditUserProvider not found in context');
    }

    return result.state;
  }

  @override
  bool updateShouldNotify(EditUserProvider oldWidget) {
    return false;
  }
}

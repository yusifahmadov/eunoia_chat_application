import 'package:eunoia_chat_application/features/conversation/presentation/pages/add_participants/add_participants_provider_state.dart';
import 'package:flutter/material.dart';

class AddParticipantsProvider extends InheritedWidget {
  final AddParticipantsProviderState state;

  const AddParticipantsProvider({super.key, required super.child, required this.state});

  static AddParticipantsProviderState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AddParticipantsProvider>();

    if (result == null) {
      throw Exception('AddParticipantsProvider not found in context');
    }

    return result.state;
  }

  @override
  bool updateShouldNotify(AddParticipantsProvider oldWidget) {
    return false;
  }
}

import 'package:eunoia_chat_application/features/message/presentation/pages/information/group_information_provider_state.dart';
import 'package:flutter/material.dart';

class GroupInformationProvider extends InheritedWidget {
  final GroupInformationProviderState state;

  const GroupInformationProvider({super.key, required super.child, required this.state});

  static GroupInformationProviderState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<GroupInformationProvider>();

    if (result == null) {
      throw Exception('GroupInformationProvider not found in context');
    }

    return result.state;
  }

  @override
  bool updateShouldNotify(GroupInformationProvider oldWidget) {
    return false;
  }
}

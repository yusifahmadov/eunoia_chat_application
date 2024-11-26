import 'package:eunoia_chat_application/features/conversation/presentation/pages/group/make_group_page_provider_state.dart';
import 'package:flutter/material.dart';

class MakeGroupPageProvider extends InheritedWidget {
  final MakeGroupPageProviderState state;

  const MakeGroupPageProvider({super.key, required super.child, required this.state});

  static MakeGroupPageProviderState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<MakeGroupPageProvider>();

    if (result == null) {
      throw Exception('MakeGroupPageProvider not found in context');
    }

    return result.state;
  }

  @override
  bool updateShouldNotify(MakeGroupPageProvider oldWidget) {
    return false;
  }
}

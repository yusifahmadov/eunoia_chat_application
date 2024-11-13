import 'package:flutter/material.dart';

import 'profile_page_provider_state.dart';

class ProfilePageProvider extends InheritedWidget {
  final ProfilePageProviderState state;
  const ProfilePageProvider({super.key, required super.child, required this.state});

  static ProfilePageProviderState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<ProfilePageProvider>();

    if (result == null) {
      throw Exception('ProfilePageProvider not found in context');
    }
    return result.state;
  }

  @override
  bool updateShouldNotify(ProfilePageProvider oldWidget) {
    return false;
  }
}

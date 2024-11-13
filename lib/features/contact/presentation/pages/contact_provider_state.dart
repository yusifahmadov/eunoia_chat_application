import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/mixins/debouncer_mixin.dart';
import '../../../../core/mixins/page_scrolling_mixin.dart';
import '../../../../core/shared_preferences/shared_preferences_user_manager.dart';
import '../../../../injection.dart';
import '../cubit/contact_cubit.dart';
import 'contact_page.dart';
import 'contact_provider.dart';

class ContactProviderWidget extends StatefulWidget {
  const ContactProviderWidget({super.key});

  @override
  State<ContactProviderWidget> createState() => ContactProviderState();
}

class ContactProviderState extends State<ContactProviderWidget>
    with DebouncerSearchMixin, PageScrollingMixin {
  final contactCubit = getIt<ContactCubit>();

  @override
  void initState() {
    initializeScrolling(function: () async {
      await contactCubit.getContacts();
    });
    super.initState();
  }

  searchContacts({required String query}) async {
    contactCubit.helperClass = contactCubit.helperClass.copyWith(username: query);
    contactCubit.getContacts(refreshScroll: true);
  }

  checkContact({required String id}) async {
    int? conversationId = (await contactCubit.checkContact(id: id));
    context.go('/conversations/details/$conversationId',
        extra: [(await SharedPreferencesUserManager.getUser())?.user.id, conversationId]);
  }

  @override
  Widget build(BuildContext context) {
    return ContactProvider(
      state: this,
      child: const ContactPage(),
    );
  }
}

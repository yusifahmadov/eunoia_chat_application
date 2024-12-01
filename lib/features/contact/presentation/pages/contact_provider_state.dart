import 'package:eunoia_chat_application/core/constant/constants.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/conversation.dart';
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
    Conversation? conversation =
        (await contactCubit.checkContact(id: id).whenComplete(() {}));
    conversationCubit.fetchedData.add(conversation!);
    conversationCubit.getConversations(isUIRefresh: true);

    context.go('/conversations/details/${conversation.id}',
        extra: [(await SharedPreferencesUserManager.getUser())?.user, conversation]);
  }

  @override
  Widget build(BuildContext context) {
    return ContactProvider(
      state: this,
      child: const ContactPage(),
    );
  }
}

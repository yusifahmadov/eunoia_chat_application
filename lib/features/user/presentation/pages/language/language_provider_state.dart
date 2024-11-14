import 'package:eunoia_chat_application/core/constant/constants.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/language/language_page.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/language/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LanguageProviderWidget extends StatefulWidget {
  const LanguageProviderWidget({super.key});

  @override
  State<LanguageProviderWidget> createState() => LanguageProviderState();
}

class LanguageProviderState extends State<LanguageProviderWidget> {
  changeLanguage(String language) {
    mainCubit.updateLanguage(language);
    context.pop();
  }

  final ValueNotifier<String> languageNotifier = ValueNotifier(mainCubit.languageValue);
  @override
  Widget build(BuildContext context) {
    return LanguageProvider(
      state: this,
      child: const LanguagePage(),
    );
  }
}

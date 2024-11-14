import 'package:eunoia_chat_application/core/extensions/localization_extension.dart';
import 'package:eunoia_chat_application/features/main/presentation/widgets/custom_button.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/language/language_provider.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/language/language_provider_state.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

extension _AdvancedContext on BuildContext {
  LanguageProviderState get state => LanguageProvider.of(this);
}

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder(
          valueListenable: context.state.languageNotifier,
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Wrap(
                runSpacing: 20,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mainContext?.localization?.change_language ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 25),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        mainContext?.localization?.language_content_message ?? "",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  CheckboxListTile(
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    value: value == 'en',
                    title: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/gb.svg',
                          width: 15,
                          height: 15,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("English"),
                      ],
                    ),
                    onChanged: (bool? value) {
                      if (value == true) {
                        context.state.languageNotifier.value = 'en';
                      }
                    },
                  ),
                  CheckboxListTile(
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    value: value == 'az',
                    title: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/az.svg',
                          width: 15,
                          height: 15,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("Azərbaycanca"),
                      ],
                    ),
                    onChanged: (bool? value) {
                      if (value == true) {
                        context.state.languageNotifier.value = 'az';
                      }
                    },
                  ),
                  CustomTextButton(
                      maxSize: true,
                      onPressed: () {
                        context.state
                            .changeLanguage(context.state.languageNotifier.value);
                      },
                      text: mainContext?.localization?.save ?? "")
                ],
              ),
            );
          }),
    );
  }
}

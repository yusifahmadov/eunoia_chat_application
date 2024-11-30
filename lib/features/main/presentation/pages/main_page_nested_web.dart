import 'package:eunoia_chat_application/features/main/presentation/widgets/custom_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPageNestedWeb extends StatelessWidget {
  const MainPageNestedWeb({
    required this.body,
    super.key,
  });
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(child: body),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {}, child: const CustomSvgIcon(text: 'chatbubbles')),
                    InkWell(
                        onTap: () {}, child: const CustomSvgIcon(text: 'person-outline')),
                    InkWell(
                        onTap: () {
                          context.go('/profile');
                        },
                        child: const CustomSvgIcon(text: 'cog-outline')),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: body,
        ),
      ],
    ));
  }
}

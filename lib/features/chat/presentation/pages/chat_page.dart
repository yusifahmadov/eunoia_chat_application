import 'package:eunoia_chat_application/core/extensions/localization_extension.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localization?.messages ?? ""),
      ),
    );
  }
}

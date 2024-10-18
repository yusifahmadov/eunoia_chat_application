import 'package:eunoia_chat_application/features/main/presentation/widgets/themed_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            context.go('/home');
          },
        ),
        title: const Text(
          'Xəta',
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ThemedContainer(
        child: const Center(
          child: Text(
            'Səhifə tapılmadı!',
          ),
        ),
      ),
    );
  }
}

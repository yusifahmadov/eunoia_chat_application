import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Text(
          'Hello, World!',
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}

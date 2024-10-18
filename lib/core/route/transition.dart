import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideUpPageRoute extends CustomTransitionPage<dynamic> {
  SlideUpPageRoute({
    required super.key,
    required super.child,
  }) : super(
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1), // Start below the screen
              end: Offset.zero,
            ).animate(
              animation,
            ),
            child: child,
          ),
        );
}

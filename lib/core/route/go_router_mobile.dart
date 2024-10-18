import 'package:eunoia_chat_application/core/route/error_screen.dart';
import 'package:eunoia_chat_application/core/route/transition.dart';
import 'package:eunoia_chat_application/core/shared_preferences/custom_shared_preferences.dart';
import 'package:eunoia_chat_application/features/chat/presentation/pages/chat_page.dart';
import 'package:eunoia_chat_application/features/main/presentation/pages/main_page.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/auth_page.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/profile/profile_page.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/signin/signin_provider_state.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/signup/signup_provider_state.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _shellProfileNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellHomeNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router = GoRouter(
      errorBuilder: (context, state) => const ErrorScreen(),
      navigatorKey: navigatorKey,
      initialLocation: '/',
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          redirect: (context, state) async {
            if (await CustomSharedPreferences.readUser('user') != null) {
              return '/home';
            }
            return '/auth';
          },
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainPageView(
              body: navigationShell,
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: navigationShell.goBranch,
            );
          },
          parentNavigatorKey: navigatorKey,
          branches: [
            StatefulShellBranch(navigatorKey: _shellHomeNavigatorKey, routes: [
              GoRoute(
                parentNavigatorKey: _shellHomeNavigatorKey,
                path: '/home',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ChatPage()),
                routes: const [],
              ),
            ]),
            StatefulShellBranch(navigatorKey: _shellProfileNavigatorKey, routes: [
              GoRoute(
                parentNavigatorKey: _shellProfileNavigatorKey,
                path: '/profile',
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProfilePage()),
              ),
            ])
          ],
        ),
        GoRoute(
          path: '/auth',
          routes: [
            GoRoute(
              path: 'signin',
              pageBuilder: (context, state) => SlideUpPageRoute(
                  key: state.pageKey, child: const SigninProviderWidget()),
            ),
            GoRoute(
              path: 'signup',
              pageBuilder: (context, state) => SlideUpPageRoute(
                  key: state.pageKey, child: const SignupProviderWidget()),
            ),
          ],
          builder: (context, state) {
            return const AuthPage();
          },
        ),
      ]);
}

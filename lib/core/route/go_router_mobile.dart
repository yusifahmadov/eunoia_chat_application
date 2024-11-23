import 'package:eunoia_chat_application/features/user/domain/entities/user.dart';
import 'package:eunoia_chat_application/features/user/presentation/cubit/user_cubit.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/edit/edit_user_provider_state.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/language/language_provider_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/contact/presentation/pages/contact_provider_state.dart';
import '../../features/conversation/presentation/pages/conversation_provider_state.dart';
import '../../features/main/presentation/pages/main_page.dart';
import '../../features/message/presentation/pages/message_provider_state.dart';
import '../../features/user/presentation/pages/auth_page.dart';
import '../../features/user/presentation/pages/profile/profile_page_provider_state.dart';
import '../../features/user/presentation/pages/signin/signin_provider_state.dart';
import '../../features/user/presentation/pages/signup/signup_provider_state.dart';
import '../../injection.dart';
import '../shared_preferences/custom_shared_preferences.dart';
import 'error_screen.dart';
import 'transition.dart';

class AppRouter {
  static final _shellProfileNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellHomeNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellContactsNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router = GoRouter(
      errorBuilder: (context, state) => const ErrorScreen(),
      navigatorKey: navigatorKey,
      initialLocation: '/',
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          redirect: (context, state) async {
            if (await CustomSharedPreferences.readUser('user') != null) {
              return '/conversations';
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
                path: '/conversations',
                routes: [
                  GoRoute(
                    path: 'details/:id',
                    parentNavigatorKey: navigatorKey,
                    routes: const [],
                    pageBuilder: (context, state) => NoTransitionPage(
                        child: MessageProviderWidget(
                      userId: (state.extra as List)[0] as String,
                      conversationId: (state.extra as List)[1] as int?,
                      e2eeEnabled: (state.extra as List)[2] as bool,
                    )),
                  ),
                ],
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ConversationProviderWidget()),
              ),
            ]),
            StatefulShellBranch(navigatorKey: _shellContactsNavigatorKey, routes: [
              GoRoute(
                path: '/contacts',
                parentNavigatorKey: _shellContactsNavigatorKey,
                routes: const [],
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ContactProviderWidget()),
              ),
            ]),
            StatefulShellBranch(navigatorKey: _shellProfileNavigatorKey, routes: [
              GoRoute(
                parentNavigatorKey: _shellProfileNavigatorKey,
                path: '/profile',
                routes: [
                  GoRoute(
                    parentNavigatorKey: navigatorKey,
                    path: '/languages',
                    pageBuilder: (context, state) =>
                        const NoTransitionPage(child: LanguageProviderWidget()),
                  ),
                  GoRoute(
                    parentNavigatorKey: navigatorKey,
                    path: '/edit-profile',
                    pageBuilder: (context, state) => NoTransitionPage(
                        child: EditUserProviderWidget(
                      user: (state.extra as List)[0] as User,
                      userCubit: (state.extra as List)[1] as UserCubit,
                    )),
                  ),
                ],
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: ProfilePageProviderWidget()),
              ),
            ]),
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

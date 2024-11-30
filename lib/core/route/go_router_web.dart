import 'package:eunoia_chat_application/core/route/error_screen.dart';
import 'package:eunoia_chat_application/core/route/transition.dart';
import 'package:eunoia_chat_application/core/shared_preferences/custom_shared_preferences.dart';
import 'package:eunoia_chat_application/features/contact/presentation/pages/contact_provider_state.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/conversation.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/pages/conversation_provider_state.dart';
import 'package:eunoia_chat_application/features/main/presentation/pages/home_page.dart';
import 'package:eunoia_chat_application/features/main/presentation/pages/main_page_web.dart';
import 'package:eunoia_chat_application/features/message/presentation/pages/message_provider_state.dart';
import 'package:eunoia_chat_application/features/user/domain/entities/user.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/auth_page.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/signin/signin_provider_state.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/signup/signup_provider_state.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouterWeb {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');
  static final GlobalKey<NavigatorState> _internalNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'internal');
  static final _shellProfileNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellHomeNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellContactsNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellConversationNavigatorKey = GlobalKey<NavigatorState>();

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
          return MainPageViewWeb(
            body: navigationShell,
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: navigationShell.goBranch,
          );
        },
        parentNavigatorKey: navigatorKey,
        branches: [
          StatefulShellBranch(navigatorKey: _shellConversationNavigatorKey, routes: [
            GoRoute(
              path: '/conversations',
              routes: [
                GoRoute(
                  path: 'details/:id',
                  builder: (context, state) {
                    final conversation = (state.extra as List)[1] as Conversation;
                    return MessageProviderWidget(
                      conversation: conversation,
                      key: ValueKey(state.pathParameters['id']),
                      myInformation: (state.extra as List)[0] as User,
                    );
                  },
                ),
              ],
              builder: (context, state) {
                return const ConversationProviderWidget(); // List of conversations
              },
            ),
            GoRoute(
              path: '/home',
              routes: const [],
              builder: (context, state) {
                return const HomePage(); // List of conversations
              },
            ),
          ]),

          StatefulShellBranch(navigatorKey: _shellContactsNavigatorKey, routes: [
            GoRoute(
              path: '/contacts',
              builder: (context, state) {
                return const ContactProviderWidget();
              },
            ),
          ]),
          // StatefulShellBranch(navigatorKey: _shellProfileNavigatorKey, routes: [
          //   ShellRoute(
          //     builder: (context, state, navigationShell) {
          //       return MainPageViewWeb(
          //         body: navigationShell,
          //       );
          //     },
          //     routes: [
          //       GoRoute(
          //         path: '/profile',
          //         parentNavigatorKey: _rootNavigatorKey, // Open as a root-level route
          //         pageBuilder: (context, state) =>
          //             const NoTransitionPage(child: ProfilePageProviderWidget()),
          //         routes: [
          //           GoRoute(
          //             path: 'languages',
          //             parentNavigatorKey: _rootNavigatorKey, // Align with root navigator
          //             pageBuilder: (context, state) =>
          //                 const NoTransitionPage(child: LanguageProviderWidget()),
          //           ),
          //           GoRoute(
          //             path: 'edit-profile',
          //             parentNavigatorKey: _rootNavigatorKey, // Align with root navigator
          //             pageBuilder: (context, state) => NoTransitionPage(
          //                 child: EditUserProviderWidget(
          //               user: (state.extra as List)[0] as User,
          //               userCubit: (state.extra as List)[1] as UserCubit,
          //             )),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ]),
        ],
      ),
      // ShellRoute(
      //   builder: (context, state, navigationShell) {
      //     return MainPageViewWeb(
      //       body: navigationShell,
      //     );
      //   },
      //   parentNavigatorKey: navigatorKey,
      //   routes: [
      //     GoRoute(
      //       path: '/home',
      //       pageBuilder: (context, state) => const NoTransitionPage(
      //         child: HomePage(),
      //       ),
      //     ),
      //     GoRoute(
      //       path: '/conversations',
      //       routes: [
      //         GoRoute(
      //           path: 'details/:id',
      //           routes: const [],
      //           pageBuilder: (context, state) => NoTransitionPage(
      //               child: MessageProviderWidget(
      //             key: ValueKey(state.pathParameters['id']),
      //             conversation: (state.extra as List)[1] as Conversation,
      //             myInformation: (state.extra as List)[0] as User,
      //           )),
      //         ),
      //       ],
      //       pageBuilder: (context, state) =>
      //           const NoTransitionPage(child: ConversationProviderWidget()),
      //     ),
      //     GoRoute(
      //       path: '/contacts',
      //       routes: const [],
      //       pageBuilder: (context, state) =>
      //           const NoTransitionPage(child: ContactProviderWidget()),
      //     ),
      //     GoRoute(
      //       path: '/profile',
      //       routes: [
      //         GoRoute(
      //           path: '/languages',
      //           pageBuilder: (context, state) =>
      //               const NoTransitionPage(child: LanguageProviderWidget()),
      //         ),
      //         GoRoute(
      //           path: '/edit-profile',
      //           pageBuilder: (context, state) => NoTransitionPage(
      //               child: EditUserProviderWidget(
      //             user: (state.extra as List)[0] as User,
      //             userCubit: (state.extra as List)[1] as UserCubit,
      //           )),
      //         ),
      //       ],
      //       pageBuilder: (context, state) =>
      //           const NoTransitionPage(child: ProfilePageProviderWidget()),
      //     ),
      //   ],
      // ),
      GoRoute(
        path: '/auth',
        routes: [
          GoRoute(
            path: 'signin',
            pageBuilder: (context, state) =>
                SlideUpPageRoute(key: state.pageKey, child: const SigninProviderWidget()),
          ),
          GoRoute(
            path: 'signup',
            pageBuilder: (context, state) =>
                SlideUpPageRoute(key: state.pageKey, child: const SignupProviderWidget()),
          ),
        ],
        builder: (context, state) {
          return const AuthPage();
        },
      ),
    ],
  );
}

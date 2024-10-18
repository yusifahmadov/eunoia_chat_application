import 'package:eunoia_chat_application/core/route/error_screen.dart';
import 'package:eunoia_chat_application/core/route/transition.dart';
import 'package:eunoia_chat_application/core/shared_preferences/custom_shared_preferences.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/auth_page.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/signin/signin_provider_state.dart';
import 'package:eunoia_chat_application/features/user/presentation/pages/signup/signup_provider_state.dart';
import 'package:eunoia_chat_application/injection.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router = GoRouter(
      errorBuilder: (context, state) => const ErrorScreen(),
      navigatorKey: navigatorKey,
      initialLocation: '/home',
      routes: <RouteBase>[
        GoRoute(
          path: '/home',
          redirect: (context, state) async {
            if (await CustomSharedPreferences.readUser('user') != null) {
              return '/';
            }
            return '/auth';
          },
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

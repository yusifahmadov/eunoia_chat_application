import 'package:eunoia_chat_application/core/route/go_router_web.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constant/constants.dart';
import 'core/route/go_router_mobile.dart';
import 'core/supabase/supabase_repository.dart';
import 'core/theme/app_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});

    Supabase.instance.client.auth.onAuthStateChange.listen((e) async {
      if (e.event == AuthChangeEvent.signedIn) {
        print('asdasd');
        await FirebaseMessaging.instance.requestPermission();

        final fcmToken = await FirebaseMessaging.instance.getToken();
        print("FCM Token: $fcmToken");
        if (fcmToken != null) {
          await _saveFcmToken(fcmToken);
        }
      }
    });
    FirebaseMessaging.instance.onTokenRefresh.listen((e) async {
      await _saveFcmToken(e);
    });

    super.initState();
  }

  Future<void> _saveFcmToken(String fcmToken) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    print('USER ID: $userId');
    if (userId == null) {
      return;
    }

    await Supabase.instance.client
        .from('users')
        .update({'fcm_token': fcmToken}).eq('id', userId);
  }

  @override
  void dispose() async {
    await SupabaseRepository.closeSocket();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          StreamBuilder<bool>(
            stream: mainCubit.isLightMode,
            builder: (context, snapshot) {
              return StreamBuilder<String>(
                  stream: mainCubit.language,
                  builder: (context, snapshot) {
                    return MaterialApp.router(
                      debugShowCheckedModeBanner: false,
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: const [
                        Locale('en'),
                        Locale('az'),
                      ],
                      builder: EasyLoading.init(
                        builder: (context, child) {
                          const textScaleFactor = 0.8;

                          return MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              textScaler: const TextScaler.linear(textScaleFactor),
                            ),
                            child: child!,
                          );
                        },
                      ),
                      locale: Locale(mainCubit.languageValue),
                      theme: ThemeManager.craeteTheme(
                          mainCubit.themeValue ? AppThemeLight() : AppThemeDark()),
                      routeInformationProvider: kIsWeb
                          ? AppRouterWeb.router.routeInformationProvider
                          : AppRouter.router.routeInformationProvider,
                      routeInformationParser: kIsWeb
                          ? AppRouterWeb.router.routeInformationParser
                          : AppRouter.router.routeInformationParser,
                      routerDelegate: kIsWeb
                          ? AppRouterWeb.router.routerDelegate
                          : AppRouter.router.routerDelegate,
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}

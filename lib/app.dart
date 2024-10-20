import 'package:eunoia_chat_application/core/constant/constants.dart';
import 'package:eunoia_chat_application/core/route/go_router_mobile.dart';
import 'package:eunoia_chat_application/core/supabase/supabase_repository.dart';
import 'package:eunoia_chat_application/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Future.delayed(const Duration(seconds: 5), () async {});
    });

    super.initState();
  }

  @override
  void dispose() async {
    await SupabaseRepository.closeSocket();
    print('Socket closed');
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
              return MaterialApp.router(
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
                locale: const Locale('en'),
                theme: ThemeManager.craeteTheme(
                    mainCubit.themeValue ? AppThemeDark() : AppThemeLight()),
                routeInformationProvider: AppRouter.router.routeInformationProvider,
                routeInformationParser: AppRouter.router.routeInformationParser,
                routerDelegate: AppRouter.router.routerDelegate,
              );
            },
          ),
        ],
      ),
    );
  }
}

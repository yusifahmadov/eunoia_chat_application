import 'package:eunoia_chat_application/core/shared_preferences/custom_shared_preferences.dart';
import 'package:eunoia_chat_application/core/shared_preferences/shared_preferences_user_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/bloc/bloc_observer.dart';
import 'firebase_options.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  di.init();
  await dotenv.load(fileName: 'assets/dotenv.txt');
  Bloc.observer = AppBlocObserver();

  (await CustomSharedPreferences.readUser("userdata")) != null
      ? await Supabase.initialize(
          url: dotenv.get('SUPABASE_API_ENDPOINT'),
          anonKey: dotenv.get('SUPABASE_API_KEY'),
          headers: {
            "Authorization":
                "Bearer ${(await SharedPreferencesUserManager.getUser())?.accessToken}"
          },
          realtimeClientOptions: const RealtimeClientOptions(
            eventsPerSecond: 2,
          ),
        )
      : await Supabase.initialize(
          url: dotenv.get('SUPABASE_API_ENDPOINT'),
          anonKey: dotenv.get('SUPABASE_API_KEY'),
          realtimeClientOptions: const RealtimeClientOptions(
            eventsPerSecond: 2,
          ),
        );

  runApp(const App());
}

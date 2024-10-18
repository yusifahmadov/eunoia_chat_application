import 'package:eunoia_chat_application/app.dart';
import 'package:eunoia_chat_application/core/bloc/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'injection.dart' as di;

void main() async {
  di.init();
  await dotenv.load(fileName: 'assets/.env');
  Bloc.observer = AppBlocObserver();

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_API_ENDPOINT'),
    anonKey: dotenv.get('SUPABASE_API_KEY'),
    realtimeClientOptions: const RealtimeClientOptions(
      eventsPerSecond: 2,
    ),
  );
  runApp(const App());
}

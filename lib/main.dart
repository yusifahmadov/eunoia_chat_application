import 'package:eunoia_chat_application/app.dart';
import 'package:eunoia_chat_application/core/bloc/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'injection.dart' as di;

void main() {
  di.init();
  dotenv.load(fileName: 'assets/.env');
  Bloc.observer = AppBlocObserver();
  runApp(const App());
}

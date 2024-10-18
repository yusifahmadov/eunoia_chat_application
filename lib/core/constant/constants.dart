import 'dart:ui';

import 'package:eunoia_chat_application/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:eunoia_chat_application/features/main/presentation/cubit/main_cubit.dart';
import 'package:eunoia_chat_application/injection.dart';

final mainCubit = getIt<MainCubit>();
final authCubit = getIt<AuthenticationCubit>();
const greenColor = Color.fromARGB(255, 0, 157, 120);

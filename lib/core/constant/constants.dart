import 'dart:ui';

import 'package:eunoia_chat_application/features/conversation/presentation/cubit/conversation_cubit.dart';

import '../../features/authentication/presentation/cubit/authentication_cubit.dart';
import '../../features/main/presentation/cubit/main_cubit.dart';
import '../../injection.dart';

final mainCubit = getIt<MainCubit>();
final authCubit = getIt<AuthenticationCubit>();
const greenColor = Color.fromARGB(255, 0, 157, 120);
final ConversationCubit conversationCubit = getIt<ConversationCubit>();

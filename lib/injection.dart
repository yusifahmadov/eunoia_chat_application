import 'package:dio/dio.dart';
import 'package:eunoia_chat_application/core/dio/interceptor.dart';
import 'package:eunoia_chat_application/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:eunoia_chat_application/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:eunoia_chat_application/features/chat/data/datasources/chat_remote_data_source_impl.dart';
import 'package:eunoia_chat_application/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:eunoia_chat_application/features/chat/domain/repositories/chat_repository.dart';
import 'package:eunoia_chat_application/features/chat/domain/usecases/get_conversations_usecase.dart';
import 'package:eunoia_chat_application/features/chat/domain/usecases/listen_conversations_usecase.dart';
import 'package:eunoia_chat_application/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:eunoia_chat_application/features/main/presentation/cubit/main_cubit.dart';
import 'package:eunoia_chat_application/features/user/data/datasources/user_remote_data_source.dart';
import 'package:eunoia_chat_application/features/user/data/datasources/user_remote_data_source_impl.dart';
import 'package:eunoia_chat_application/features/user/data/repositories/user_repository_impl.dart';
import 'package:eunoia_chat_application/features/user/domain/repositories/user_repository.dart';
import 'package:eunoia_chat_application/features/user/domain/usecases/user_login_usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/usecases/user_register_usecase.dart';
import 'package:eunoia_chat_application/features/user/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  initUseCases();
  initCubits();
  initDataSources();
  initRepositories();
  initExternals();
}

initCubits() {
  getIt.registerFactory(
      () => UserCubit(userLoginUsecase: getIt(), userRegisterUsecase: getIt()));
  getIt.registerFactory(() => MainCubit());
  getIt.registerFactory(() =>
      ChatCubit(getConversationsUsecase: getIt(), listenConversationsUsecase: getIt()));
  getIt.registerFactory(() => AuthenticationCubit());
}

initDataSources() {
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(),
  );
}

initUseCases() {
  getIt.registerLazySingleton(() => UserLoginUsecase(userRepository: getIt()));
  getIt.registerLazySingleton(() => UserRegisterUsecase(userRepository: getIt()));
  getIt.registerLazySingleton(() => GetConversationsUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => ListenConversationsUsecase(repository: getIt()));
}

initRepositories() {
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(remoteDataSource: getIt()),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();
final mainContext = navigatorKey.currentContext;
final dio = Dio();
initExternals() {
  getIt.registerLazySingleton(() => navigatorKey);

  getIt.registerLazySingleton(
    () => Dio()
      ..options = BaseOptions(baseUrl: dotenv.get('SUPABASE_API_ENDPOINT'))
      ..interceptors.add(CustomInterceptor()),
  );
}

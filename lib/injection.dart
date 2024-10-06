import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:zenith_planner_app/core/dio/interceptor.dart';
import 'package:zenith_planner_app/features/user/data/datasources/user_remote_data_source.dart';
import 'package:zenith_planner_app/features/user/data/datasources/user_remote_data_source_impl.dart';
import 'package:zenith_planner_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:zenith_planner_app/features/user/domain/repositories/user_repository.dart';
import 'package:zenith_planner_app/features/user/domain/usecases/user_login_usecase.dart';
import 'package:zenith_planner_app/features/user/domain/usecases/user_register_usecase.dart';
import 'package:zenith_planner_app/features/user/presentation/cubit/user_cubit.dart';

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
}

initDataSources() {
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );
}

initUseCases() {
  getIt.registerLazySingleton(() => UserLoginUsecase(userRepository: getIt()));
  getIt.registerLazySingleton(() => UserRegisterUsecase(userRepository: getIt()));
}

initRepositories() {
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userRemoteDataSource: getIt()),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();
final mainContext = navigatorKey.currentContext;
initExternals() {
  getIt.registerLazySingleton(() => navigatorKey);

  getIt.registerLazySingleton(
    () => Dio()
      ..options = BaseOptions(baseUrl: dotenv.get('SUPABASE_API_ENDPOINT'))
      ..interceptors.add(CustomInterceptor()),
  );
}

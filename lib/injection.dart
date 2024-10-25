import 'package:dio/dio.dart';
import 'package:eunoia_chat_application/core/dio/interceptor.dart';
import 'package:eunoia_chat_application/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:eunoia_chat_application/features/contact/data/datasources/contact_remote_data_source.dart';
import 'package:eunoia_chat_application/features/contact/data/datasources/contact_remote_data_source_impl.dart';
import 'package:eunoia_chat_application/features/contact/data/repositories/contact_repository_impl.dart';
import 'package:eunoia_chat_application/features/contact/domain/repositories/contact_repository.dart';
import 'package:eunoia_chat_application/features/contact/domain/usecases/check_contact_usecase.dart';
import 'package:eunoia_chat_application/features/contact/domain/usecases/get_contact_usecase.dart';
import 'package:eunoia_chat_application/features/contact/domain/usecases/search_contact_usecase.dart';
import 'package:eunoia_chat_application/features/contact/presentation/cubit/contact_cubit.dart';
import 'package:eunoia_chat_application/features/conversation/data/datasources/conversation_remote_data_source.dart';
import 'package:eunoia_chat_application/features/conversation/data/datasources/conversation_remote_data_source_impl.dart';
import 'package:eunoia_chat_application/features/conversation/data/repositories/conversation_repository_impl.dart';
import 'package:eunoia_chat_application/features/conversation/domain/repositories/conversation_repository.dart';
import 'package:eunoia_chat_application/features/conversation/domain/usecases/get_conversations_usecase.dart';
import 'package:eunoia_chat_application/features/conversation/domain/usecases/listen_conversations_usecase.dart';
import 'package:eunoia_chat_application/features/conversation/presentation/cubit/conversation_cubit.dart';
import 'package:eunoia_chat_application/features/main/presentation/cubit/main_cubit.dart';
import 'package:eunoia_chat_application/features/message/data/datasources/message_remote_data_source.dart';
import 'package:eunoia_chat_application/features/message/data/datasources/message_remote_data_source_impl.dart';
import 'package:eunoia_chat_application/features/message/data/repositories/message_repository_impl.dart';
import 'package:eunoia_chat_application/features/message/domain/repositories/message_repository.dart';
import 'package:eunoia_chat_application/features/message/domain/usecases/get_messages_usecase.dart';
import 'package:eunoia_chat_application/features/message/domain/usecases/listen_messages_usecase.dart';
import 'package:eunoia_chat_application/features/message/domain/usecases/read_messages_by_conversation_usecase.dart';
import 'package:eunoia_chat_application/features/message/domain/usecases/read_messages_usecase.dart';
import 'package:eunoia_chat_application/features/message/domain/usecases/send_message_usecase.dart';
import 'package:eunoia_chat_application/features/message/presentation/cubit/message_cubit.dart';
import 'package:eunoia_chat_application/features/user/data/datasources/user_remote_data_source.dart';
import 'package:eunoia_chat_application/features/user/data/datasources/user_remote_data_source_impl.dart';
import 'package:eunoia_chat_application/features/user/data/repositories/user_repository_impl.dart';
import 'package:eunoia_chat_application/features/user/domain/repositories/user_repository.dart';
import 'package:eunoia_chat_application/features/user/domain/usecases/get_current_user_usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/usecases/get_user_usecase.dart';
import 'package:eunoia_chat_application/features/user/domain/usecases/refresh_token_usecase.dart';
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
  getIt.registerFactory(() => UserCubit(
      userLoginUsecase: getIt(),
      getCurrentUserUsecase: getIt(),
      userRegisterUsecase: getIt(),
      getUserUsecase: getIt(),
      refreshTokenUsecase: getIt()));
  getIt.registerFactory(() => MainCubit());
  getIt.registerFactory(() => ContactCubit(
        getContactUsecase: getIt(),
        searchContactUsecase: getIt(),
        checkContactUsecase: getIt(),
      ));
  getIt.registerFactory(() => MessageCubit(
        readMessagesUsecase: getIt(),
        getMessagesUsecase: getIt(),
        sendMessageUsecase: getIt(),
        readMessagesByConversationUsecase: getIt(),
        listenMessagesUsecase: getIt(),
      ));

  getIt.registerFactory(() => ConversationCubit(
        getConversationsUsecase: getIt(),
        listenConversationsUsecase: getIt(),
      ));

  getIt.registerFactory(() => AuthenticationCubit());
}

initDataSources() {
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<ConversationRemoteDataSource>(
    () => ConversationRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<MessageRemoteDataSource>(
    () => MessageRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ContactRemoteDataSource>(
    () => ContactRemoteDataSourceImpl(),
  );
}

initUseCases() {
  getIt.registerLazySingleton(() => UserLoginUsecase(userRepository: getIt()));
  getIt.registerLazySingleton(() => UserRegisterUsecase(userRepository: getIt()));
  getIt.registerLazySingleton(() => GetConversationsUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => ListenConversationsUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => GetMessagesUsecase(messageRepository: getIt()));
  getIt.registerLazySingleton(() => SendMessageUsecase(messageRepository: getIt()));
  getIt.registerLazySingleton(() => GetCurrentUserUsecase(userRepository: getIt()));
  getIt.registerLazySingleton(() => ListenMessagesUsecase(messageRepository: getIt()));
  getIt.registerLazySingleton(() => ReadMessagesUsecase(messageRepository: getIt()));
  getIt.registerLazySingleton(() => GetContactUsecase(contactRepository: getIt()));
  getIt.registerLazySingleton(() => CheckContactUsecase(contactRepository: getIt()));
  getIt.registerLazySingleton(() => SearchContactUsecase(contactRepository: getIt()));
  getIt.registerLazySingleton(() => RefreshTokenUsecase(userRepository: getIt()));
  getIt.registerLazySingleton(() => GetUserUsecase(userRepository: getIt()));
  getIt.registerLazySingleton(
      () => ReadMessagesByConversationUsecase(messageRepository: getIt()));
}

initRepositories() {
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userRemoteDataSource: getIt()),
  );

  getIt.registerLazySingleton<ConversationRepository>(
    () => ConversationRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<ContactRepository>(
    () => ContactRepositoryImpl(contactRemoteDataSource: getIt()),
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

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:eunoia_chat_application/features/chat/data/models/conversation_model.dart';
import 'package:eunoia_chat_application/features/chat/domain/entities/conversation.dart';
import 'package:eunoia_chat_application/features/chat/domain/entities/helper/get_conversations_helper.dart';
import 'package:eunoia_chat_application/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ResponseI, List<Conversation>>> getConversations(
      GetConversationsHelper body) async {
    try {
      return Right(await remoteDataSource.getConversations(body: body));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, ConversationModel?>> listenConversations(
      void Function({required ConversationModel conversation}) callBackFunc) async {
    try {
      return Right(
          await remoteDataSource.listenConversations(callBackFunc: callBackFunc));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }
}

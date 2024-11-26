import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/group_data.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/add_participants_to_group_helper.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/make_group_conversation_helper.dart';

import '../../../../core/response/response.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/entities/helper/get_conversations_helper.dart';
import '../../domain/repositories/conversation_repository.dart';
import '../datasources/conversation_remote_data_source.dart';
import '../models/conversation_model.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationRemoteDataSource remoteDataSource;

  ConversationRepositoryImpl({required this.remoteDataSource});

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

  @override
  Future<Either<ResponseI, void>> addParticipantsToGroupConversation(
      AddParticipantsToGroupHelper body) async {
    try {
      return Right(
          await remoteDataSource.addParticipantsToGroupConversation(body: body.toJson()));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, int>> makeGroupConversation(
      MakeGroupConversationHelper body) async {
    try {
      return Right(await remoteDataSource.makeGroupConversation(body: body.toJson()));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, List<GroupData>>> getGroupData(int conversationId) async {
    try {
      return Right(await remoteDataSource.getGroupData(conversationId));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, void>> addGroupPhoto(body) async {
    try {
      return Right(await remoteDataSource.addGroupPhoto(body: body));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, ResponseI>> leaveGroup(int conversationId) async {
    try {
      return Right(await remoteDataSource.leaveGroup(conversationId));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }
}

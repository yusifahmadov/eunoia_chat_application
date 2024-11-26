import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eunoia_chat_application/features/conversation/domain/entities/helper/send_group_message_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/encryption_request.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/handle_encryption_request_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/listen_encryption_requests_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/send_encryption_request_helper.dart';

import '../../../../core/response/response.dart';
import '../../domain/entities/helper/get_message_helper.dart';
import '../../domain/entities/helper/listen_message_helper.dart';
import '../../domain/entities/helper/read_messages_helper.dart';
import '../../domain/entities/helper/send_message_helper.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/message_repository.dart';
import '../datasources/message_remote_data_source.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource remoteDataSource;

  MessageRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ResponseI, List<Message>>> getMessages(
      {required GetMessageHelper body}) async {
    try {
      return Right(await remoteDataSource.getMessages(body: body));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, void>> sendMessage({required SendMessageHelper body}) async {
    try {
      return Right(await remoteDataSource.sendMessage(body: body));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, Message?>> listenMessages(
      {required ListenMessageHelper body}) async {
    try {
      return Right(await remoteDataSource.listenMessages(body: body));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, void>> readMessages({required ReadMessagesHelper body}) async {
    try {
      return Right(await remoteDataSource.readMessages(body: body));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, void>> readMessagesByConversation(
      {required ReadMessagesHelper body}) async {
    try {
      return Right(await remoteDataSource.readMessagesByConversation(body: body));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, ResponseI>> sendEncryptionRequest(
      SendEncryptionRequestHelper body) async {
    try {
      return Right(await remoteDataSource.sendEncryptionRequest(body: body));
    } on DioException catch (e) {
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, List<EncryptionRequest>>> getLastEncryption(
      int conversationId) async {
    try {
      return Right(
          await remoteDataSource.getEncryptionRequest(conversationId: conversationId));
    } on DioException catch (e) {
      print(e.response);
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, ResponseI>> handleEncryptionRequest(
      {required HandleEncryptionRequestHelper body}) async {
    try {
      return Right(await remoteDataSource.handleEncryptionRequest(body: body));
    } on DioException catch (e) {
      print(e.response);
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, EncryptionRequest?>> listenEncryptionRequests(
      ListenEncryptionRequestsHelper body) async {
    try {
      return Right(await remoteDataSource.listenEncryptionRequests(body: body));
    } on DioException catch (e) {
      print(e.response);
      return Left(ResponseI(message: e.response.toString()));
    }
  }

  @override
  Future<Either<ResponseI, void>> sendGroupMessage(SendGroupMessageHelper body) async {
    try {
      return Right(await remoteDataSource.sendGroupMessage(body: body.toJson()));
    } on DioException catch (e) {
      print(e.response);
      return Left(ResponseI(message: e.response.toString()));
    }
  }
}

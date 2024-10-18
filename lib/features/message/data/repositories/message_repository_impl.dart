import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/features/message/data/datasources/message_remote_data_source.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/get_message_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/listen_message_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/send_message_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/message.dart';
import 'package:eunoia_chat_application/features/message/domain/repositories/message_repository.dart';

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
}

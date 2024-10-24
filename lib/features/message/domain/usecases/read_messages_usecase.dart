import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/read_messages_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/repositories/message_repository.dart';

class ReadMessagesUsecase extends Usecase<void, ReadMessagesHelper> {
  final MessageRepository messageRepository;

  ReadMessagesUsecase({required this.messageRepository});

  @override
  Future<Either<ResponseI, void>> call(params) {
    return messageRepository.readMessages(body: params);
  }
}

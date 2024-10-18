import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/listen_message_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/message.dart';
import 'package:eunoia_chat_application/features/message/domain/repositories/message_repository.dart';

class ListenMessagesUsecase extends Usecase<Message?, ListenMessageHelper> {
  final MessageRepository messageRepository;

  ListenMessagesUsecase({required this.messageRepository});

  @override
  Future<Either<ResponseI, Message?>> call(params) {
    return messageRepository.listenMessages(body: params);
  }
}

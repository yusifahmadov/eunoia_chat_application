import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/get_message_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/message.dart';
import 'package:eunoia_chat_application/features/message/domain/repositories/message_repository.dart';

class GetMessagesUsecase extends Usecase<List<Message>, GetMessageHelper> {
  final MessageRepository messageRepository;

  GetMessagesUsecase({required this.messageRepository});

  @override
  Future<Either<ResponseI, List<Message>>> call(params) {
    return messageRepository.getMessages(body: params);
  }
}

import 'package:dartz/dartz.dart';
import 'package:eunoia_chat_application/core/response/response.dart';
import 'package:eunoia_chat_application/core/usecase/usecase.dart';
import 'package:eunoia_chat_application/features/message/domain/entities/helper/send_message_helper.dart';
import 'package:eunoia_chat_application/features/message/domain/repositories/message_repository.dart';

class SendMessageUsecase extends Usecase<void, SendMessageHelper> {
  final MessageRepository messageRepository;

  SendMessageUsecase({required this.messageRepository});

  @override
  Future<Either<ResponseI, void>> call(params) {
    return messageRepository.sendMessage(body: params);
  }
}

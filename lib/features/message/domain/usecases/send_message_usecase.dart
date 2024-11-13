import 'package:dartz/dartz.dart';

import '../../../../core/response/response.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/helper/send_message_helper.dart';
import '../repositories/message_repository.dart';

class SendMessageUsecase extends Usecase<void, SendMessageHelper> {
  final MessageRepository messageRepository;

  SendMessageUsecase({required this.messageRepository});

  @override
  Future<Either<ResponseI, void>> call(params) {
    return messageRepository.sendMessage(body: params);
  }
}
